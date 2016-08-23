class GroupsController < ApplicationController
	def show
		@group = Group.find(params[:group_id])
	end
end
