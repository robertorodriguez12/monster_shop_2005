class MerchantsController <ApplicationController

  before_action :require_merchant

  def index
    require "pry"; binding.pry
    require_admin
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.save
      redirect_to merchants_path
    else
      flash[:error] = merchant.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash[:error] = @merchant.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  def require_merchant
   render_404 unless current_user.merchant_employee?
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip)
  end

end
