class StaticPagesController < ApplicationController

  	def home
  		@post = current_user.posts.build if user_signed_in?
  		@feed_items = current_user.feed if user_signed_in?
  	end

end
