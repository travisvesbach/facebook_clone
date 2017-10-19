class Friendship < ApplicationRecord
	validates :user, presence: true
	validates :friend, presence: true

	belongs_to :user
	belongs_to :friend, class_name: "User" 

	def delete
		self.destroy
	end

end
