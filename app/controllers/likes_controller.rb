class LikesController < ApplicationController
	before_action :authenticate_user!

	def create
		@like = current_user.likes.build(post: Post.find_by(id: params[:post_id]))
		if @like.save
			redirect_back(fallback_location: root_url)
		end

	end

	def destroy 
		current_user.likes.find_by_post_id(params[:post_id]).destroy
		redirect_back(fallback_location: root_url)
	end

end
