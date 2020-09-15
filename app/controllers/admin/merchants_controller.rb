class Admin::MerchantsController < Admin::BaseController
  before_action :require_admin
  
  def index
    @merchants = Merchant.all
  end

end
