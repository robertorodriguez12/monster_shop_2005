require 'rails_helper'

RSpec.describe("Order show Page") do
  describe "When I view order show page from my profile" do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @user = User.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
      @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 100)
    end

    it "can see all info about the order" do

      visit '/'
      click_on "Login"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      click_on "My Orders"
      click_on "View Order"
      visit "/profile/orders/#{@order_1.id}"
      save_and_open_page
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_1.updated_at)
      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@pencil.description)
      expect(page).to have_content(@pencil.price)
      expect(page).to have_content(@pencil.item_orders.first.subtotal)
    end
  end
end
