require "rails_helper"

RSpec.describe "Admin merchant index", type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @user = User.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 2)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break", price: 40, inventory: 12, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588")
  end
  describe "As an admin" do
    it "I can see a disable button next to any merchants" do
      visit '/'
      click_on "Login"
      expect(current_path).to eq("/login")

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_on "Login to Account"
      click_on "All Merchants"
      expect(page).to have_content(@bike_shop.name)

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_button('Disable')
      end
    end

      it "I can press disable button and disable an account " do
        visit '/'
        click_on "Login"
        expect(current_path).to eq("/login")

        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        click_on "All Merchants"

        within "#merchant-#{@bike_shop.id}" do
          click_on "Disable"
          expect(current_path).to eq('/admin/merchants')
        end

        expect(page).to have_content("This merchant has been disabled.")
      end

      it "A disabled merchant's items are also disabled" do
        visit '/'
        visit '/items'
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@chain.name)
        click_on "Login"
        expect(current_path).to eq("/login")

        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        click_on "All Merchants"

        within "#merchant-#{@bike_shop.id}" do
          click_on "Disable"
          expect(current_path).to eq('/admin/merchants')
        end

        visit '/items'

        expect(page).to_not have_content(@tire.name)
        expect(page).to_not have_content(@chain.name)
      end

      it "I can see an enable button next to the merchant and click it" do
        visit '/'
        click_on "Login"
        expect(current_path).to eq("/login")

        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        click_on "All Merchants"
        expect(page).to have_content(@bike_shop.name)

        within "#merchant-#{@bike_shop.id}" do
          click_on "Disable"
          expect(current_path).to eq('/admin/merchants')
        end

        within "#merchant-#{@bike_shop.id}" do
          expect(page).to have_button('Enable')
        end

        within "#merchant-#{@bike_shop.id}" do
          click_on "Enable"
          expect(current_path).to eq('/admin/merchants')
        end

        expect(page).to have_content("This merchant is now enabled.")
      end
      it "A disabled merchant's items are also disabled" do
        visit '/'
        click_on "Login"
        expect(current_path).to eq("/login")

        fill_in :email, with: @user.email
        fill_in :password, with: @user.password
        click_on "Login to Account"
        click_on "All Merchants"

        within "#merchant-#{@bike_shop.id}" do
          click_on "Disable"
          expect(current_path).to eq('/admin/merchants')
        end

        visit '/items'

        expect(page).to_not have_content(@tire.name)
        expect(page).to_not have_content(@chain.name)

        click_on "All Merchants"
        
        within "#merchant-#{@bike_shop.id}" do
          click_on "Enable"
          expect(current_path).to eq('/admin/merchants')
        end

        visit '/items'
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@chain.name)
      end
  end
end
