class Admin < ApplicationRecord
  has_many :merchants
  has_many :users
  has_many :orders, through: :users
  has_many :items, through: :merchants
end
