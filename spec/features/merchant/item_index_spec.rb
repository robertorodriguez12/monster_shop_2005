require "rails_helper"

RSpec.describe "Merchant Item Index Page", type: :feature do
  describe "As a merchant" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @user = @bike_shop.users.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 1)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break", price: 40, inventory: 12, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588")
    end

    it "I can see all my items with information" do
      visit '/'
      click_on "Login"
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"

      visit '/merchant/items'

        within"#item-#{@tire.id}" do
          expect(page).to have_content(@tire.name)
          expect(page).to have_content(@tire.description)
          expect(page).to have_content(@tire.price)
          expect(page).to have_content(@tire.image)
          expect(page).to have_content(@tire.active?)
          expect(page).to have_content(@tire.inventory)
          click_on "Deactivate"
        end

      expect(current_path).to eq('/merchant/items')
      expect(page).to have_content("This item is no longer for sale.")
      expect(page).to have_content("false")
    end

  end
end
