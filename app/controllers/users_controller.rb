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

  def edit
    current_user
  end

  def update
    current_user.update(user_params)
    if current_user.save
      flash[:notice] = "Successfully updated your information!"
      redirect_to "/profile"
    else
      flash[:error] = "Please fill in all fields."
      redirect_to request.referer
    end
  end

  def update_password
    current_user.update(user_params)
    if current_user.save
      flash[:notice] = "Successfully updated your password!"
      redirect_to "/profile"
    else
      flash[:error] = "Please have matching fields before submission."
      render :edit_password
    end
  end

  def edit_password
    current_user
  end

  private

  def user_params
    params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
