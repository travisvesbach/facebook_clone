module NotificationsHelper

  	def remove_notifications
    	@notifications = Notification.select { |f| f.user == current_user or f.from == current_user}
    	@notifications.each { |f| f.delete }
    end

end
