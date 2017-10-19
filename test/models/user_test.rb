require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@dude = users(:dude)
  	@guy = users(:guy)
  end

  test "should be valid" do
  	assert @dude.valid?
  end

  test "email should be present" do
  	@dude.email = ' '
  	assert_not @dude.valid?
  end

  test "associated posts should be destroyed" do
  	@dude.posts.create!(content: "pork!")
  	assert_difference 'Post.count', -1 do
  		@dude.destroy
  	end
  end

end
