class Admin::DashboardController < Admin::BaseController

  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: "shipped")
    redirect_to request.referer
  end

end
