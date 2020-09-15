require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  describe "As a visitor" do
    it "can login" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user = bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 1)

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Login to Account"
      expect(current_path).to eq("/merchant")
    end

    it "cannot log in with bad credentials" do
      user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao", role: 1)

      visit "/"
      click_on "Login"

      fill_in :email, with: user.email
      fill_in :password, with: "incorrect password"

      click_on "Login to Account"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Sorry, your credentials are bad.")
    end

    it "can be redirected to correct path if already logged in" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user = bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 1)

      visit "/"
      click_on "Login"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login to Account"

      expect(current_path).to eq('/merchant')

      visit "/login"

      expect(current_path).to eq('/merchant')
      expect(page).to have_content("You are already logged in.")
    end
  end
end
