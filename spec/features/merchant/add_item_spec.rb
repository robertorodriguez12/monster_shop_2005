require "rails_helper"

RSpec.describe "Merchant add item", type: :feature do
  describe "As a Merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 1)
    end
    it "I can add an item" do
      visit '/'
      click_on "Login"
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"

      visit '/merchant/items'

      expect(page).to have_link("Add New Item")
      click_on "Add New Item"
      expect(current_path).to eq('/merchant/items/new')

      fill_in 'Name', with: "Tire"
      fill_in 'Description', with: "Really strong"
      fill_in 'Price', with: 20
      fill_in 'Inventory', with: 20
      click_on 'Create Item'
      expect(current_path).to eq('/merchant/items')

      expect(page).to have_content("Your item has been created")
      expect(page).to have_content("Tire")
    end

  end
end
