class Merchant::ItemsController < Merchant::BaseController

  def index
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

end
