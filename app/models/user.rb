class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true

  validates_presence_of :password, require: true
  validates_presence_of :name, :street_address, :city, :state, :zip

  enum role: [:regular_user, :merchant_employee, :admin_user]

  has_secure_password

  has_many :orders

  def unique_email?
    User.pluck(:email).include?(email)
  end
end
