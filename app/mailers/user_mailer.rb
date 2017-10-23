class UserMailer < ApplicationMailer

	def welcome_mailer(user)
		@user = user
		mail(to: @user.email, subject: "Welcome to Travis's Facebook clone!")
	end

end
