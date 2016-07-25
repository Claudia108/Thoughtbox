class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Account Created! Logged in as #{@user.email}"
      redirect_to links_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def show
    render file: '/public/404' if current_user.nil?
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
