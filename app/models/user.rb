class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

    has_many :friendships
    has_many :friends, -> { where('accepted = ?', true) }, through: :friendships

    has_many :notifications, dependent: :destroy
    has_many :posts, dependent: :destroy 
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    default_scope -> { order(name: :asc) }

    after_create :send_welcome_mail

    # Returns all of a user's unread notifications
    def unread_notifications
    	self.notifications.select { |n| n.read == false }
    end

    # Returns all the posts from a user and their friends for displaying on that user's homepage
    def feed_with_friends
    	friend_ids = "SELECT user_id FROM friendships WHERE friend_id = :user_id AND accepted = true"
    	Post.where("user_id IN (#{friend_ids}) OR user_id = :user_id", user_id: id)
    end

    # checks to see if a user already likes a specific post
    def like?(post)
    	self.likes.find_by_post_id(post.id)
    end

    # Removes all of a user's notifications
    def remove_all_notifications
      @notifications = Notification.select { |f| f.user == self or f.from == self}
      @notifications.each { |f| f.delete }
    end

    # Removes all notifications from a specific user
    def remove_friend_notifications(target_user)
      @notifications = Notification.select { |f| f.user == self and f.from == target_user}
      @notifications.each { |f| f.delete }
    end

    # Removes all of a user's comments from a different specific user
    def remove_comments_from_friend_post(target_user)
      @comments = Comment.select { |f| f.user == self and f.post.user == target_user}
      @comments.each { |f| f.delete }
    end

    # Removes all of a user's likes from a different specific user
    def remove_likes_from_friend_post(target_user)
      @likes = Like.select { |f| f.user == self and f.post.user == target_user}
      @likes.each { |f| f.delete }
    end

    # Sets user variables from values recieved from Facebook by omniauth
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        name_parts = user.name.split(" ")
        user.first_name = name_parts.first
        user.last_name = name_parts.last
        user.image = auth.info.image
      end
    end

    # Sends a welcome email
    def send_welcome_mail
      UserMailer.welcome_mailer(self).deliver_now
    end

end