class Merchant::DashboardController < Merchant::BaseController

  def index
  end

  def show
    if current_user.role == "merchant_employee"
      @merchant = Merchant.find(current_user.merchant_id)
    end
  end

end
