class Merchant::ItemsController < Merchant::BaseController

  def index
  end

  def new
    @item = Merchant.find(current_user.merchant_id).items.new
  end

  def create
    @item = Merchant.find(current_user.merchant_id).items.new(item_params)
    @item.save
    flash[:success] = "Your item has been created"
    redirect_to '/merchant/items'
  end

  def update
    @item = Item.find(params[:id])
    if params[:disable_enable] == 'enable'
      @item.enable
      flash[:success] = "This item is active again."
      redirect_to '/merchant/items'
    else
      @item.disable
      flash[:success] = "This item is no longer for sale."
      redirect_to '/merchant/items'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:destroy] = "#{@item.name} is now deleted"
    redirect_to '/merchant/items'
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price, :inventory)
  end

end
