class ApplicationController < ActionController::Base
	helper_method :current_user,:logged_in?

	private
	def ensure_login
		if !session[:user_id]
			flash[:info] = "Please Log In First"
			redirect_to login_path
		end
	end

	def current_user
		@current_user ||= User.find_by_id(session[:user_id])
	end

	def logged_in?
		current_user != nil
	end
end
