class UsersController < ApplicationController

  def new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "You are now registered and logged in!"
      redirect_to '/profile'
    else
      flash[:failure] = "You are missing fields, please fill in all fields to register!"
      redirect_to request.referer
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
