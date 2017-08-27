class SessionsController < ApplicationController
	def create
		user = User.find_by_email(params[:email])
		if user.try(:authenticate, params[:password])
			session[:user_id] = user.id
			redirect_to organizations_path
		else
			flash[:errors] = ["Invalid email or password"]
			redirect_to :back
		end
	end

	def destroy
		session.clear
		redirect_to root_path
	end
end
