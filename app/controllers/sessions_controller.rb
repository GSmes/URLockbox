class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid credentials. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully logged out!"
    redirect_to login_path
  end
end
