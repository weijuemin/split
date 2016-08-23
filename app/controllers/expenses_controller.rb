class ExpensesController < ApplicationController
	def new
		@group = Group.find(params[:group_id])
	end
	def create
		redirect_to "/group/#{ params[:group_id] }"
	end
	def show
	end
end
