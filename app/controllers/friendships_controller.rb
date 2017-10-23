class FriendshipsController < ApplicationController
	before_action :user_signed_in?

	def create
		@target_user = User.find_by(id: params[:user_id])
		@seeded_users = [1,2,3,4,5]
		if @seeded_users.include? @target_user.id 
			Friendship.create!(user: current_user, friend: @target_user, accepted: true)
			Friendship.create!(user: @target_user, friend: current_user, accepted: true)	
			Notification.create!(user: current_user, from: @target_user, content: "#{@target_user.name} accepted your friend request! You are now friends!", topic: "friend")
			flash[:notice] = "Friend added! You are now friends with #{@target_user.name}!" 					
		else
			Friendship.create!(user: current_user, friend: @target_user)
			Notification.create!(user: @target_user, from: current_user, content: "#{current_user.name} sent you a friend request!", topic: "friend")
			flash[:notice] = 'Friend request sent.'
		end
		redirect_back(fallback_location: root_url)
	end

	def update
		@target_user = User.find_by(id: params[:user_id])
		@friendship = Friendship.find_by(user: @target_user, friend: current_user)
		@friendship.update_attribute(:accepted, true) 
		Friendship.create!(user: current_user, friend: @target_user, accepted: true)
		Notification.create!(user: @target_user, from: current_user, content: "#{current_user.name} accepted your friend request! You are now friends!", topic: "friend")
		flash[:notice] = "Friend added! You are now friends with #{@target_user.name}!" 
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
