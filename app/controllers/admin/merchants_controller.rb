class Admin::MerchantsController < Admin::BaseController
  before_action :require_admin

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def disable_merchant
    @merchant = Merchant.find(params[:id])
    @merchant.disable
    flash[:success] = "This merchant has been disabled."
    redirect_to '/admin/merchants'
  end

end
