class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :friendships
    has_many :friends, -> { where('accepted = ?', true) }, through: :friendships

    has_many :notifications, dependent: :destroy
    has_many :posts, dependent: :destroy 
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    def unread_notifications
    	self.notifications.select { |n| n.read == false }
    end

    def feed 
    	friend_ids = "SELECT user_id FROM friendships WHERE friend_id = :user_id AND accepted = true"
    	Post.where("user_id IN (#{friend_ids}) OR user_id = :user_id", user_id: id)
    end

    def like?(post)
    	self.likes.find_by_post_id(post.id)
    end

    def remove_all_notifications
      @notifications = Notification.select { |f| f.user == self or f.from == self}
      @notifications.each { |f| f.delete }
    end

    def remove_friend_notifications(target_user)
      @notifications = Notification.select { |f| f.user == self and f.from == target_user or f.user == target_user and f.from == self}
      @notifications.each { |f| f.delete }
    end

end