class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit]
  def create
  	@user = User.create(first_name:params[:first_name],last_name:params[:last_name],username: params[:username],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation],profilepic:params[:profilepic])
  	@user.password_digest
  	if @user.valid? == true
  		session[:user_id] = @user.id
  		flash[:message] = ["Successful Registration"]
  		redirect_to controller: :users, action: :show
  	else
  		flash[:message] = @user.errors.full_messages
  		redirect_to controller: :sessions, action: :index
  	end
  end

  def show
    @user = current_user
    groupIds = []
    x = @user.user_groups
    if x.count > 0
      x.each do |ug|
        groupIds << ug.id
      end
    end
    @groups = Group.where("id IN (#{groupIds.join(',')})")
    
    expenses = @user.expenses.where(completed:false)
    @owes, @owed = {}, {}
    expenses.each do |e|
      result = outstanding(e)
      result.each do |r|
        if r[:owes] == @user
          if @owes.has_key? r[:owed]
            @owes[r[:owed]] += r[:amt]
          else
            @owes[r[:owed]] = r[:amt]
          end
        elsif r[:owed] == @user
          if @owed.has_key? r[:owes]
            @owed[r[:owes]] += r[:amt]
          else
            @owed[r[:owes]] = r[:amt]
          end
        end
      end
    end
    render 'users/user_show.html'
  end

  def edit
    render 'edit.html'
  end

  def update
    @user = current_user
    @user.update(first_name:params[:first_name],last_name:params[:last_name],username: params[:username],email:params[:email],profilepic:params[:profilepic])
    if @user.valid? == true
      flash[:message] = ["User Updated"]
      redirect_to action: :show
    else
      flash[:message] = @user.errors.full_messages
      redirect_to action: :edit
    end
  end

  def settle
    @user = current_user
    expenses = @user.expenses.where(completed:false)
    @owed_user = User.find(params[:id])
    @owes_list = []
    @total = 0
    expenses.each do |e|
      result = outstanding(e)
      result.each do |r|
        if r[:owes] == @user && r[:owed] == @owed_user
          @total += r[:amt]
          r[:expense] = e
          @owes_list << r
        end
      end
    end
  end

  def clear
    user = current_user
    expenses = user.expenses.where(completed:false)
    expenses.each do |e|
      result = outstanding(e)
      result.each do |r|
        if r[:owes] == user && r[:owed] == User.find(params[:id])
          r1 = Record.find_by(user:user, expense:e)
        end
      end
    end
    redirect_to "/users"
  end

end
