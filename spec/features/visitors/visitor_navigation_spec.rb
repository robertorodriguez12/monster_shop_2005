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
    end
  end
end
