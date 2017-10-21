class FriendshipsController < ApplicationController


	def create
		@target_user = User.find_by(id: params[:user_id])
		Friendship.create!(user: current_user, friend: @target_user)
		Notification.create!(user: @target_user, from: current_user, content: "#{current_user} sent you a friend request!", topic: "friend")
		flash[:notice] = 'Friend request sent.'
		redirect_to @target_user
	end

	def update
		@target_user = User.find_by(id: params[:user_id])
		@friendship = Friendship.find_by(user: @target_user, friend: current_user)
		@friendship.update_attribute(:accepted, true) 
		Friendship.create!(user: current_user, friend: @target_user, accepted: true)
		Notification.create!(user: @target_user, from: current_user, content: "#{current_user} accepted your friend request! You are now friends!", topic: "friend")
		flash[:notice] = "Friend added! You are now friends with #{@target_user}!" 
		redirect_to @target_user
	end

	def destroy
		@target_user = User.find_by(id: params[:user_id])
		@friendship_from_user = Friendship.find_by(user: current_user, friend: @target_user)
		@friendship_to_user = Friendship.find_by(user: @target_user, friend: current_user)
		if !@friendship_from_user.nil? and !@friendship_to_user.nil?
			@friendship_from_user.delete
			@friendship_to_user.delete
			flash[:notice] = "You've unfriended someone."			
		elsif !@friendship_from_user.nil? and @friendship_to_user.nil?
			current_user.remove_friend_notifications(@target_user)			
			@friendship_from_user.delete
			flash[:notice] = 'Friend request cancelled'
		elsif @friendship_from_user.nil? and !@friendship_to_user.nil?
			@friendship_to_user.delete
			flash[:notice] = 'Friend request declined'
		end
		redirect_to @target_user
	end

end
