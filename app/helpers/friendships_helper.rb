module FriendshipsHelper

	# returns the current friendship status between two users
	def friendship_status(user)
		@target_user = user
		@friendship_from_user = Friendship.find_by(user: current_user, friend: @target_user)
		@friendship_to_user = Friendship.find_by(user: @target_user, friend: current_user)

		if !@friendship_from_user.nil?
			if @friendship_from_user.accepted == true
				return 'friends'
			else
				return 'request sent'
			end
		elsif !@friendship_to_user.nil?
			if @friendship_to_user.accepted == false
				return 'accept friend request'
			end
		else
			false
		end
	end

	# Removes all of a user's friendships
	def remove_friendships
    	@friendships = Friendship.select { |f| f.user == current_user or f.friend == current_user}
    	@friendships.each { |f| f.delete }
    end
    
end
