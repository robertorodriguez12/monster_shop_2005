class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true

  validates_presence_of :password, require: true
  has_secure_password

  def unique_email?
    User.pluck(:email).include?(email)
  end

end
