require 'rails_helper'

RSpec.describe "Logout" do
  describe "user" do
    it "can logout" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      user = User.create(name: "John Doe", street_address: "123 Main Street", city: "Anytown", state: "Anystate", zip: 123456, email: "funbucket13@gmail.com", password: "test", role: 1)

      visit "/"
      click_on "Login"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login to Account"

      expect(current_path).to eq('/merchant')

      visit "/items/#{@tire.id}"

      click_on "Add To Cart"

      click_on "Logout"

      expect(current_path).to eq('/')
      expect(page).to have_content("Cart: 0")
      expect(page).to have_content("You've successfully logged out.")
    end
  end
end
