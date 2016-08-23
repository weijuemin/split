class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit]
  def create
  	@user = User.create(first_name:params[:first_name],last_name:params[:last_name],username: params[:username],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation])
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
    render 'users/user_show.html'
  end

  def edit
    render 'edit.html'
  end

  def update
    @user = current_user
    @user.update(first_name:params[:first_name],last_name:params[:last_name],username: params[:username],email:params[:email])
    if @user.valid? == true
      flash[:message] = ["User Updated"]
      redirect_to action: :show
    else
      flash[:message] = @user.errors.full_messages
      redirect_to action: :edit
    end
  end
end
