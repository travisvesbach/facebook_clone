class FriendshipsController < ApplicationController


	def create
		@target_user = User.find_by(id: params[:user_id])
		Friendship.create!(user: current_user, friend: @target_user)
		Notification.create!(user: @target_user, from: current_user, content: "#{current_user} sent you a friend request!", topic: "friend")
		flash[:notice] = 'Friend request sent.'
		redirect_back(fallback_location: root_url)
	end

	def update
		@target_user = User.find_by(id: params[:user_id])
		@friendship = Friendship.find_by(user: @target_user, friend: current_user)
		@friendship.update_attribute(:accepted, true) 
		Friendship.create!(user: current_user, friend: @target_user, accepted: true)
		Notification.create!(user: @target_user, from: current_user, content: "#{current_user} accepted your friend request! You are now friends!", topic: "friend")
		flash[:notice] = "Friend added! You are now friends with #{@target_user}!" 
		redirect_back(fallback_location: root_url)
	end

	def destroy
		@target_user = User.find_by(id: params[:user_id])
		@friendship_from_user = Friendship.find_by(user: current_user, friend: @target_user)
		@friendship_to_user = Friendship.find_by(user: @target_user, friend: current_user)
		if !@friendship_from_user.nil? and !@friendship_to_user.nil?
			current_user.remove_friend_notifications(@target_user)
			@target_user.remove_friend_notifications(current_user)
			current_user.remove_comments_from_friend_post(@target_user)
			current_user.remove_likes_from_friend_post(@target_user)
			@friendship_from_user.delete
			@friendship_to_user.delete
			flash[:notice] = "You've unfriended someone."			
		elsif !@friendship_from_user.nil? and @friendship_to_user.nil?
			current_user.remove_friend_notifications(@target_user)
			@target_user.remove_friend_notifications(current_user)
			@friendship_from_user.delete
			flash[:notice] = 'Friend request cancelled'
		elsif @friendship_from_user.nil? and !@friendship_to_user.nil?
			@friendship_to_user.delete
			flash[:notice] = 'Friend request declined'
		end
		redirect_back(fallback_location: root_url)
	end

end
