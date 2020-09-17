require "rails_helper"

RSpec.describe "Edit Item", type: :feature do
  describe "As a Merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 1)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break", price: 40, inventory: 12, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588")
    end

    it "can edit an item" do
      visit '/'
      click_on "Login"
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"

      visit '/merchant/items'

      within"#item-#{@tire.id}" do
        expect(page).to have_link("Edit")
        click_on "Edit"
      end

      expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")
      expect(find_field('Name').value).to eq(@tire.name)
      expect(find_field('Description').value).to eq(@tire.description)
      expect(find_field('Price').value).to eq('100')
      expect(find_field('Inventory').value).to eq('12')
      fill_in 'Name', with: "Diamond"
      click_on 'Update Item'

      expect(current_path).to eq('/merchant/items')
      expect(page).to have_content("Your item has been updated.")
      within"#item-#{@tire.id}" do
        expect(page).to have_content("Diamond")
      end
    end

    it "cant edit an item with missing information" do
      visit '/'
      click_on "Login"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      visit '/merchant/items'

      within"#item-#{@tire.id}" do
        click_on "Edit"
      end

      expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")
      expect(find_field('Name').value).to eq(@tire.name)
      expect(find_field('Description').value).to eq(@tire.description)
      expect(find_field('Price').value).to eq('100')
      expect(find_field('Inventory').value).to eq('12')
      fill_in 'Name', with: ''
      click_on 'Update Item'

      expect(page).to have_content("Please fill in all fields to continue.")

      expect(find_field('Name').value).to eq(@tire.name)
      expect(find_field('Description').value).to eq(@tire.description)
      expect(find_field('Price').value).to eq('100')
      expect(find_field('Inventory').value).to eq('12')
    end
  end
end
