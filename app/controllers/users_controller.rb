class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account created successfully!"
      redirect_to root_path
    else
      flash.now[:danger] = user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
