class UsersController < ApplicationController
	before_action :authenticate_user!
	include FriendshipsHelper
  include NotificationsHelper

  	def index
  		@users = User.all
  	end

  	def show
  		@user = User.find_by(id: params[:id])
      @post = current_user.posts.build if user_signed_in?
  	end

  	def destroy
      remove_notifications
  		remove_friendships
  		redirect_to current_user.destroy
  	end

end
