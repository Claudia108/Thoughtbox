class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.email}"
      redirect_to links_path
    else
      flash.now[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end
end
