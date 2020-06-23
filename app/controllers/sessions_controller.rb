class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  
  end

  def create
    user = User.find_by(username: session_params[:username].downcase)
      if user && user.authenticate(session_params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome #{user.username} You are successfully Logged In"
        redirect_to root_path
      else
        flash.now[:error] = "Invalid Credentials"
        render :new
      end
  end

  def destroy
      session[:user_id] = nil
      flash[:success] = "Logged out"
      redirect_to root_path
  end

  def session_params
      params.require(:session).permit(:username, :password)
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already loggedin"
      redirect_to root_path
    end 
  end
  
  end