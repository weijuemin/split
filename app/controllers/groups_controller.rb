class GroupsController < ApplicationController
	def display
		@user = User.find(session[:user_id])
		@groups = @user.groups
	end

	def show
		@group = Group.find(params[:group_id])
	end
end
