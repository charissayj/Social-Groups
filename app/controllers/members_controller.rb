class MembersController < ApplicationController
	def create
		@organization = Organization.find(params[:id])

		Member.create(user: current_user, organization: @organization)

		return redirect_to :back
	end

	def destroy
	  	@organization = Organization.find(params[:id])
	  	Member.find_by(organization: @organization, user: current_user).delete

	  	return redirect_to :back
	end
end
