class Admin::MerchantsController < Admin::BaseController
  before_action :require_admin

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:disable_enable] == 'enable'
      @merchant.enable
      flash[:success] = "This merchant is now enabled."
      redirect_to '/admin/merchants'
    else
      @merchant.disable
      flash[:success] = "This merchant has been disabled."
      redirect_to '/admin/merchants'
    end
  end

end
