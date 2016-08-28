class SessionsController < ApplicationController
  before_action :require_login, only: [:reset]
  def index
    if logged_in
      redirect_to "/users"
    end
  end

  def registerPage
    render 'register.html'
  end

  def loginPage
    if logged_in
      redirect_to "/users"
    else
      render 'login.html'
    end
  end

  def login
  	@user = User.find_by(email: params[:email])
  	if @user && @user.authenticate(params[:password])
  		flash[:message]=['Successful Login']
  		session[:user_id]=@user.id
  		redirect_to controller: :users, action: :show
  	else
  		flash[:message]=['Invalid Login']
  		redirect_to action: :loginPage
  	end
  end

  def reset
    if logged_in
    	session.destroy
    	redirect_to "/"
    end
  end

  def catch_all
    if logged_in
      redirect_to "/users"
    else
      redirect_to "/"
    end
  end
end
