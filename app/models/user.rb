class User < ApplicationRecord
	has_secure_password

	validates :displayName, length: {minimum: 8, too_short: "\"displayName\" length must be at least %{count} characters long" }, allow_blank: true
	validates :password, length: {minimum: 6, too_short: "length must be at least %{count} characters long" }
	validates :email, presence: { message: "\"email\" is required" }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "\"email\" must be a valid email" }

	has_many :posts
end