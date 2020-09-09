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
      flash[:failure] = "User Registration Warning: You are missing #{pluralize(quantity, "field")}:#{empty_fields_convert}!"
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

  def empty_fields(current_params)
    @user_empty_fields = []
    current_params.each do |key, value|
      if value == ""
        @user_empty_fields << key.capitalize
      end
    end
    @user_empty_fields
  end

  def empty_fields_convert
    empty_fields_string = String.new
    @user_empty_fields.each do |field|
      empty_fields_string += field + ", "
    end
    empty_fields_string = empty_fields_string[0..-3].gsub("_", " ")
    empty_fields_string
  end


end
