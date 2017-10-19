class Notification < ApplicationRecord
	belongs_to :user
	belongs_to :from, class_name: "User"
end
