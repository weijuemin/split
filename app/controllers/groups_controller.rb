class GroupsController < ApplicationController
  layout "contents"
  before_action :require_login
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
    g_id = params[:group]
    input = params[:input]
    if input != ""
      group = Group.find(g_id)
      existingUIds = [];
      UserGroup.where(group: group).each do |ug|
        existingUIds << ug.user.id
      end
      @result = User.where("id NOT IN (#{existingUIds.join(',')})").where("LOWER(first_name) || ' ' || LOWER(last_name) LIKE ?", "%#{input.downcase}%").where.not(id: current_user.id)
    else
      @result = [];
    end
    render :json => @result
  end

  def membership_create
    group = Group.find(params[:g_id])
    if not params[:genUIds]
      flash[:error] = ["Please select at least one user before you can save"]
      redirect_to "/groups/#{group.id}"
      return
    end
    userIds = params[:getUIds].split(",").map {|i| i.to_i}
    userIds.each do |id|
      UserGroup.create(user: User.find(id), group: group)
    end
    redirect_to "/groups/#{group.id}"
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
