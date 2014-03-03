class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])

    if logged_in? && @user
      render :show
    else
      redirect_to new_session_url
    end
  end

  def new
    if logged_in?
      redirect_to user_url(current_user.username)
    else
      @user = User.new

      render :new
    end
  end

  def create
    @user = User.new(user_params)

    if params[:user][:password] == params[:user][:password_confirm]
      if @user.save
        sign_in(@user)
        flash[:success] ||= []
        flash[:success] << "You have successfully created an account!"

        redirect_to user_url(@user)
      else
        flash.now[:error] ||= []
        flash.now[:error] += @user.errors.full_messages

        render :new
      end
    else
      flash.now[:error] ||= []
      flash.now[:error] << "Password fields must match"

      render :new
    end
  end

  def edit
    @user = User.find_by_username(params[:username])
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
    end
end
