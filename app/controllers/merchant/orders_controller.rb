class Merchant::OrdersController < Merchant::BaseController

  def show
    @merchant = Merchant.find(params[:id])
    @order = @merchant.orders.find(params[:id])
  end
end