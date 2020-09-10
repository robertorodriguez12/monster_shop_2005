require 'rails_helper'


RSpec.describe 'merchant nav bar', type: :feature do
  describe "as a merchant user" do
    it 'it can see same links as regular user plus merchant specific links' do
      merchant = User.create(email: "fern@gully.com",
                         password: "password",
                         name: "Burt",
                         role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit "/merchants"

      within '.topnav' do
        expect(page).to have_link("Home")
        expect(page).to have_link("All Items")
        expect(page).to have_link("Profile")
        expect(page).to have_link("Logout")
        expect(page).to have_link("Dashboard")
      end
    end
  end
end
