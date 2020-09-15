require "rails_helper"

RSpec.describe "Merchant Show Page", type: :feature do
  describe "As a merchant" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(name: "Mike Dao", street_address: "blah", city: "blah", state: "blah", zip: 12345, email: "blah@email.com", password: "test", role: 1)
    end

    it "can see name and full address of the merchant I work for" do

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      expect(current_path).to eq("/merchant")
      click_on 'Dashboard'
      expect(current_path).to eq('/merchant')
      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content(@bike_shop.address)
      expect(page).to have_content(@bike_shop.city)
      expect(page).to have_content(@bike_shop.state)
      expect(page).to have_content(@bike_shop.zip)


    end

  end


#     User Story 35, Merchant Dashboard displays Orders
#
# As a merchant employee
# When I visit my merchant dashboard ("/merchant")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order show page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
end
