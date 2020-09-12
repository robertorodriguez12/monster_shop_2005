class SessionsController < ApplicationController

  def new
    if session[:user_id] != nil
      flash[:success] = "You are already logged in."
      user = User.find(session[:user_id])
      redirect_user
      end
    end


  def create
      user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}!"
        redirect_user
      else
        flash[:error] = "Sorry, your credentials are bad."
        render :new
      end
  end

  def redirect_user
    if current_user.role == "regular_user"
      redirect_to '/profile'
    elsif merchant?
      redirect_to'/merchant'
    else current_admin?
      redirect_to '/admin'
    end
  end
end
