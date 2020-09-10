class AdminController < ApplicationController

  before_action :require_admin


   def require_admin
    render_404 unless current_user.admin_user?
   end

   def show
     require_admin
   end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
