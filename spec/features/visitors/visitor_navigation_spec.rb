require "rails_helper"

RSpec.describe "Visitor navigation", type: :feature do
  describe "As a visitor" do
    it "can see a navigation bar with links" do
      visit "/"
      within '.topnav' do
        expect(page).to have_link("Register")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
        expect(page).to have_link("Cart: 0")
        expect(page).to have_link("Login")
        expect(page).to have_link("Home")
      end
      save_and_open_page
    end

  end
#
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
# - a link to log in ("/login")
# - a link to the user registration page ("/register")
#
# Next to the shopping cart link I see a count of the items in my cart
end
