require "rails_helper"

RSpec.describe "User show page", type: :feature do
  before :each do
    #=== User
    @user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao", street_address: "123 easy street", city: "Anycity", state: "Anystate", zip: 12345, role: 0)

    #=== Merchants
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    
    #=== Products
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    @order_2 = @user.orders.create(name: "#{@user.name}", address: "#{@user.street_address}", city: "#{@user.city}", state: "#{@user.state}", zip: @user.zip )
  end
  
  describe "As a user" do
    it "can login and see my info except for my password with a link to edit said data" do
      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_on "Login to Account"
      expect(current_path).to eq("/profile")
      expect(page).to have_content("#{@user.name}")
      expect(page).to have_content("#{@user.street_address}")
      expect(page).to have_content("#{@user.city}")
      expect(page).to have_content("#{@user.state}")
      expect(page).to have_content("#{@user.zip}")
      expect(page).to have_content("#{@user.email}")
      expect(page).to have_link("Edit My Info")
    end
  end
  
  describe "User Profile displays Orders" do
    it "I see a link on my profile page called 'My Orders' When I click this link my URI path is '/profile/orders'" do
      visit '/'
      click_on "Login"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      expect(current_path).to eq("/profile")
  
      visit "/cart"
      click_on "Checkout"
      
      name = "Bert"
      address = "123 Sesame St."
      city = "NYC"
      state = "New York"
      zip = 10001
  
      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip
  
      click_button "Create Order"
      click_on "Profile"
      
      ## Then I see a link on my profile page called "My Orders"
      expect(page).to have_link("My Orders")
      ## When I click this link my URI path is "/profile/orders"
      click_on "My Orders"
      expect(current_path).to eq("/profile/orders")
  
    end
    
    describe "I visit my Profile Orders page, '/profile/orders' I see every order I've made and details" do 
      it "Displays: the ID of the order, the date the order was made, the date the order was last updated, the current status of the order, the total quantity of items in the order, the grand total of all items for that order " do
        visit '/'
        click_on "Login"
        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        click_on "My Orders"
        
        expect(page).to have_content("#{@order_2.id}")
        expect(page).to have_content("#{@order_2.created_at}")
        expect(page).to have_content("#{@order_2.updated_at}")
        expect(page).to have_content("pending")
        expect(page).to have_content("#{@order_2.total_items}")
        expect(page).to have_content("#{@order_2.grandtotal}")
      end
    end
  end
end
