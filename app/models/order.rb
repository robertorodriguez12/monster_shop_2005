class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: [ :pending, :packaged, :shipped, :cancelled ]

  def grandtotal
    item_orders.sum('price * quantity')
  end
  def total_items
    # binding.pry
    # items.select('items.name').where('item_orders.item_id = items.id')

    # items.select('items.name', 'items.id','count(items.id) AS total').where('item_orders.item_id = items.id').group('items.id').order(total: :desc)
  end
  # def total_items
  #   item_orders.sum('quantity')
  # end
end
