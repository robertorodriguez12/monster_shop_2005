class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.email}"
    redirect_to '/profile' #need to update later for different users and correct path
  end
end
