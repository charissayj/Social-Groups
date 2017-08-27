class UsersController < ApplicationController
	def create
		user = User.new(user_params)

		if user.save
			session[:user_id] = user.id
			return redirect_to organizations_path
		end

		flash[:errors] = user.errors.full_messages
		return redirect_to :back
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password)
		end
end
