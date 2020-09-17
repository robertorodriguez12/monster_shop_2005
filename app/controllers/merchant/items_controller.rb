class Merchant::ItemsController < Merchant::BaseController

  def index
  end

  def update
    @item = Item.find(params[:id])
    @item.disable
    flash[:success] = "This item is no longer for sale."
    redirect_to '/merchant/items'
  end

end
