class OrdersController <ApplicationController

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = User.find(current_user.id)
    order = user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      flash[:success] = "Your order was created"
      session.delete(:cart)
      redirect_to "/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def cancel
    order = Order.find(params[:id])
    order.update(status: "cancelled")
    order.item_orders.each do |item|
      item.update(status: "unfulfilled")
    end
    order.item_orders.each do |item|
      item
    end
    flash[:success] = "Your order was cancelled"
    redirect_to "/profile"
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
