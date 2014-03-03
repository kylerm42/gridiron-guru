class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_url(current_user.username)
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user && @user.is_password?(params[:user][:password])
      sign_in(@user)
      flash[:success] ||= []
      flash[:success] << "Welcome back, #{@user.first_name}"
      redirect_to user_url(@user)
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:error] ||= []
      flash.now[:error] << "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    current_session = Session.find_by_token(session[:token])

    if current_session
      current_session.destroy
      session[:token] = nil

      flash[:notice] ||= []
      flash[:notice] << "You have been successfully signed out"

      redirect_to new_session_url
    else
      flash[:error] ||= []
      flash[:error] << "There was an error processing your request"

      redirect_to new_session_url
    end
  end
end
