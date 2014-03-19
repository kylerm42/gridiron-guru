class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def show
    if logged_in?
      find_user
      render :show
    else
      redirect_to new_session_url
    end
  end

  def new
    if logged_in?
      redirect_to root_url
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
        set_flash(:success, "You have successfully created an account!")

        redirect_to root_url
      else
        set_flash_now(:error, @user.errors.full_messages)

        render :new
      end
    else
      set_flash_now(:error, "Password fields must match")

      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if params[:user][:password] == params[:user][:password_confirm]
      if @user.update_attributes(user_params)
        sign_in(@user)
        set_flash(:success, "Account successfully updated")

        redirect_to user_url(@user)
      else
        set_flash_now(:error, @user.errors.full_messages)

        render :edit
      end
    else
      set_flash_now(:error, "Password fields must match")

      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
    end

    def find_user
      @user = User.find_by_username(params[:username]) || User.find(params[:username])
    end
end
