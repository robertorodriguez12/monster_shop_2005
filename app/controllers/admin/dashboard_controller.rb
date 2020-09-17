class Admin::DashboardController < Admin::BaseController

  def index
    @orders = Order.all
  end

  def show
    if current_user.role == "user_admin"
      @admin = Admin.find(current_user.admin_id)
    end
  end

end
