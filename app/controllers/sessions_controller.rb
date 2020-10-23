class SessionsController < ApplicationController
  def new
  	if logged_in?
			redirect_to welcome_index_path
			return
		end
	end

	def create
		@user = User.find_by_email(get_login_params[:email])
		if @user && @user.verify(get_login_params[:password])
			session[:user_id] = @user.id
			flash[:success] = 'Logged In..!!'
			redirect_to root_path()
		else
			flash.now[:danger] = 'Invalid Email Or Password..!!'
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path()
	end

	private
	def get_login_params
		params.require(:login).permit(:email,:password)
	end
end
