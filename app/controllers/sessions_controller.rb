class SessionsController < ApplicationController
  def index
  	if !flash[:message]
  		flash[:message]=[""]
  	end
  	render 'index.html'
  end
  def login
  	@user = User.find_by(email: params[:email])
  	if @user && @user.authenticate(params[:password])
  		flash[:message]=['Successful Login']
  		session[:user_id]=@user.id
  		redirect_to action: :index
  	else
  		flash[:message]=['Invalid']
  		redirect_to action: :index
  	end
  end

  def reset
  	session.destroy
  	redirect_to action: :index
  end
end
