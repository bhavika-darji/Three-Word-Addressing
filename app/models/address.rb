class Address < ApplicationRecord
	has_many :favorites
	has_many :user, through: :favorites

	def self.current_user
		current_user ||= User.find_by_id(session[:user_id])
	end
end
