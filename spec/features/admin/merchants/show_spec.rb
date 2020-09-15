require "rails_helper"

RSpec.describe "Merchant Index Page", type: :feature do
  describe "As an admin user" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break", price: 40, inventory: 12, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588")
      @user_1 = User.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
      @user_2 = User.create(email: "c@email.com", password: "test", name: "Mark", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
      @order_1 = @user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      @order_2 = @user_2.orders.create!(name: 'Mark', address: '123 Stang Ave', city: 'Owego', state: 'NY', zip: 13811)
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_2.item_orders.create!(item: @chain, price: @tire.price, quantity: 4)
      @user = User.create(email: "admin@admin.com", password: "test", name: "Mark", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 2)
    end

    it "I can visit the merchant index page and see all merchants names as links" do
      visit '/'
      click_on "Login"
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      expect(current_path).to eq("/admin")
      expect(page).to have_link("All Merchants")
      click_on "All Merchants"
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("Brian's Bike Shop")
      click_on "Brian's Bike Shop"
      expect(current_path).to eq("/merchants/#{@bike_shop.id}")
      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content("Pending Orders")
    end

  end

  # User Story 37, Admin can see a merchant's dashboard
  #
  # As an admin user
  # When I visit the merchant index page ("/merchants")
  # And I click on a merchant's name,
  # Then my URI route should be ("/admin/merchants/6")
  # Then I see everything that merchant would see
end
