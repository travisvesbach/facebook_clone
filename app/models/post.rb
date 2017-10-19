class Post < ApplicationRecord
  	validates :content, presence: true
  	validates :user_id, presence: true

  	belongs_to :user
  	default_scope -> { order(created_at: :desc) }
  	has_many :likes, dependent: :destroy
end
