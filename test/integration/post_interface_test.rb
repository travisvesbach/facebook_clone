require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

	def setup
		@user = users(:dude)
	end

	test "post interface" do
		sign_in @user
		get root_path
		# Invalid submission
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { content: "" } }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		content = "This post is hungry"
		assert_difference 'Post.count', 1 do
			post posts_path, params: { post: { content: content } }
		end
		assert_redirected_to root_url
		follow_redirect!
		assert_match content, response.body
		# Delete post
		first_post = @user.posts.first 
		assert_difference 'Post.count', -1 do
			delete post_path(first_post)
		end
	end

end
