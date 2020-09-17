class UserOrdersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

end
