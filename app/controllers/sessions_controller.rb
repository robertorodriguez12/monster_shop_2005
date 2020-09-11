class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.email}"
    redirect_user #need to update later for different users and correct path
  end

  def redirect_user
      #binding.pry
      if current_user.role == "regular_user"
        redirect_to '/profile'
      elsif merchant?
        redirect_to'/merchant'
      else current_admin?
        redirect_to '/admin'
      end
  end
end
