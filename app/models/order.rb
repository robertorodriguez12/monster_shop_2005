class Order <ApplicationRecord
  belongs_to :user

  has_many :item_orders
  has_many :items, through: :item_orders
  validates_presence_of :name, :address, :city, :state, :zip

  enum status: [ :pending, :packaged, :shipped, :cancelled ]

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.sum(:quantity)
  end

  def quantity_for_merchant(merchant_id)
    item_orders.joins(:item).where(items: {merchant_id: merchant_id}).sum(:quantity)
  end

  def total_for_merchant(merchant_id)
    item_orders.joins(:item).where(items: {merchant_id: merchant_id}).sum('item_orders.quantity * item_orders.price')
  end
end
