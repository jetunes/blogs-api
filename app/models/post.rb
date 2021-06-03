class Post < ApplicationRecord
	belongs_to :user

	validates :title, presence: { message: "\"title\" is required" }
	validates :content, presence: { message: "\"content\" is required" }
end