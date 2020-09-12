class OrdersController <ApplicationController

  def new
    if current_user.nil?
      # redirect_to cart_path, notice: "Must be #{view_context.link_to 'Registered', '/register'} or #{view_context.link_to 'Logged In', '/login'} in order to checkout".html_safe
      # flash.now[:error] = "Must be #{view_context.link_to 'Registered', '/register'} or #{view_context.link_to 'Logged In', '/login'} in order to checkout".html_safe
      redirect_to '/cart'
    else

    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/orders/#{order.id}"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
