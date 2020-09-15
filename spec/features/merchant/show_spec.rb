require "rails_helper"

RSpec.describe "Merchant Show Page", type: :feature do
  describe "As a merchant" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(name: "Mike Dao", street_address: "blah", city: "blah", state: "blah", zip: 12345, email: "blah@email.com", password: "test", role: 1)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break", price: 40, inventory: 12, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588")
      @user_1 = User.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
      @user_2 = User.create(email: "c@email.com", password: "test", name: "Mark", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)

      @order_1 = @user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      @order_2 = @user_2.orders.create!(name: 'Mark', address: '123 Stang Ave', city: 'Owego', state: 'NY', zip: 13811)
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_2.item_orders.create!(item: @chain, price: @tire.price, quantity: 4)
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

    it "can see a list of pending orders" do
      visit '/'

      click_on "Login"


      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      click_on 'Dashboard'

      within "#order-#{@order_1.id}" do
        expect(page).to have_link("#{@order_1.id}")
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.quantity_for_merchant(@bike_shop.id))
        expect(page).to have_content(@order_1.total_for_merchant(@bike_shop.id))
      end

      within "#order-#{@order_2.id}" do
        expect(page).to have_link("#{@order_2.id}")
        expect(page).to have_content(@order_2.created_at)
        expect(page).to have_content(@order_2.quantity_for_merchant(@bike_shop.id))
        expect(page).to have_content(@order_2.total_for_merchant(@bike_shop.id))
      end
    end
  end
end
