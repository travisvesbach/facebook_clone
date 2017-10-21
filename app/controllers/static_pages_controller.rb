class StaticPagesController < ApplicationController

  	def home
  		@post = current_user.posts.build if user_signed_in?
  		@feed_items = current_user.feed_with_friends if user_signed_in?
  		@comment = current_user.comments.build if user_signed_in?
  	end

end
