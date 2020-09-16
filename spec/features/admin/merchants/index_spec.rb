require "rails_helper"

RSpec.describe "Admin merchant index", type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @user = User.create(email: "c_j@email.com", password: "test", name: "Meg", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 2)
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
  end
end
