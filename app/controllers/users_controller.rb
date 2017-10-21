class UsersController < ApplicationController
	before_action :authenticate_user!
	include FriendshipsHelper

  	def index
  		@users = User.all
  	end

  	def show
  		@user = User.find_by(id: params[:id])
      @feed_items = @user.posts
      @post = current_user.posts.build if user_signed_in?
      @comment = current_user.comments.build if user_signed_in?
  	end

  	def destroy
      current_user.remove_all_notifications
  		remove_friendships
  		redirect_to current_user.destroy
  	end

end
