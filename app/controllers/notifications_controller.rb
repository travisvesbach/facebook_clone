class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  	def index
  		unless current_user.id == params[:id]
  			@notifications = current_user.notifications.all
  		else
  			redirect_to root_path
  		end
  	end

  	def show
  		notification = Notification.find_by(id: params[:id])
  		if notification.read == false
	  		notification.update_attribute(:read, true)
  		end
  		redirect_to notification.from
  	end
end
