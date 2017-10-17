class OrganizationsController < ApplicationController
	before_action :auth, only: [:destroy]

	def index
		@user = User.find(session[:user_id])
		@organizations = Organization.all
	end

	def create
		user = User.find(session[:user_id])
		organization = Organization.new(organization_params)
		organization.user = user

		if organization.save
			Member.create(user: current_user, organization: organization)
			session[:organization_id] = organization.id
			redirect_to :back
		else
			flash[:errors] = organization.errors.full_messages
			redirect_to :back
		end
	end

	def show
		@organization = Organization.find(params[:id])
	end

	def destroy
		@organization = Organization.find(params[:id])
		@member = Member.find_by(organization: @organization)

		@organization.destroy
		redirect_to :back
	end

	private
		def organization_params
			params.require(:organization).permit(:name, :description)
		end

		def auth
			@organization = Organization.find(params[:id])

			return redirect_to organizations_path unless current_user == @organization.user
		end
end
