require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  describe "As an admin" do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @admin = User.create(email: "fern@gully.com", password: "password", name: "Burt", role: 2)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @user = User.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 2)

      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)
      @order_2 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 1)
      @order_3 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 2)
      @order_4 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 3)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
      @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 100)
      @order_2.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 100)
      @order_3.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 100)
      @order_4.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 100)
    end

    it "can see all orders" do
      visit '/'
      click_on "Login"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      visit "/admin"
      expect(page).to have_content("Order id: #{@order_1.id}")
      expect(page).to have_content("User: #{@order_1.user_id}")
      expect(page).to have_content("Date Created: #{@order_1.created_at}")
      end

      it "can ship an order" do
        visit '/'
        click_on "Login"
        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        visit "/admin"
        within"#item-#{@order_1.id}" do
          click_on "Ship"
        end
        end
      end
    end
