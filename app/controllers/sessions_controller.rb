class SessionsController < ApplicationController
  before_action :require_login, only: [:reset]
  def index
  	render 'index.html'
  end

  def loginPage
    render 'login.html'
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
  	session.destroy
  	redirect_to "/sessions/"
  end
end
