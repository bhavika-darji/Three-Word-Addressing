class UsersController < ApplicationController
def new
		if logged_in?
			redirect_to welcome_index_path
			return
		end
		@user = User.new
	end

	def edit
		@user = current_user
	end

	#POST
	def create
		@user = User.new(get_user_params)
		if @user.save
			flash[:success] = 'Account Created Successfully..!!'
			session[:user_id] = @user.id
			redirect_to login_path
		else
			render 'new'
		end
	end

	def update
		if(current_user.update(get_user_params))
			flash[:success] = 'Updated Successfully..!!'
		else
			flash[:danger] = 'Cannot Update Profile..!!'
		end
		redirect_to profile_path
	end

	private
	def get_user_params
		params.require(:user).permit(:name,:email,:password,:password_confirm)
	end
end
