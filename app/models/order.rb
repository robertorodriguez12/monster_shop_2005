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
end
