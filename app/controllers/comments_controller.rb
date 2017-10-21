class CommentsController < ApplicationController
  	before_action :user_signed_in?
  	before_action :correct_user, only: [:destroy]

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			redirect_back(fallback_location: root_url)
		else
			redirect_back(fallback_location: root_url)
  		end

	end

	def destroy 
		current_user.comments.find_by(post: params[:post_id], id: params[:id]).destroy
		redirect_back(fallback_location: root_url)
	end

	private

		def comment_params
			params.require(:comment).permit(:content).merge(post: Post.find_by(id: params[:post_id]))
		end

    	def correct_user
      		@comment = current_user.comments.find_by(post: params[:post_id], id: params[:id])
      		redirect_to root_url if @comment.nil?
    	end

end
