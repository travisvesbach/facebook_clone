class Notification < ApplicationRecord
	belongs_to :user
	belongs_to :from, class_name: "User"
	default_scope -> { order(created_at: :desc) }
end
