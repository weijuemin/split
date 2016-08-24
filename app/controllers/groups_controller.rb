class GroupsController < ApplicationController
	def display
		@user = User.find(session[:user_id])
		@groups = @user.groups
	end

	def show
		@group = Group.find(params[:group_id])
    @current_user = current_user
    @members = UserGroup.where(group: @group)
	end

  def getUsers
    input = params[:input]
    @result = User.where("first_name LIKE ? or last_name LIKE ?", "%#{input}%", "%#{input}%")
    render :json => @result
  end

  def create
    group = Group.create(name: params[:gname])
    if group.valid?
      current_user.user_groups.create(group: group)
      redirect_to "/groups/#{group.id}"
    else
      flash[:error] = ["Please enter a name"]
      redirect_to "/groups"
    end
  end
end
