require "rails_helper"

RSpec.describe "Admin Navigation", type: :feature do
  describe "As an admin" do
    it "can see same links as a regular user except /cart plus link to admin dashboard and all users. " do
      admin = User.create(email: "fern@gully.com",
                         password: "password",
                         name: "Burt",
                         role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin"
      within '.topnav' do
        expect(page).to have_link("Home")
        expect(page).to have_link("Profile")
        expect(page).to have_link("Logout")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Users")
        expect(page).to_not have_link("Cart")
      end
    end

  end
end
