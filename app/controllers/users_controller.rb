class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You are now registered and logged in!"
      redirect_to '/profile'
    elsif @user.unique_email?
      flash[:error] = "This email is already in use! Please try again!!"
      render :new
    else
      flash[:failure] = "You are missing fields, please fill in all fields to register!"
      render :new
    end
  end

  def show
    render file: "/public/404" unless current_user
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
