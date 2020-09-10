
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

    end


    it "can login" do
      user = User.create(email: "funbucket13@gmail.com", password: "test")
      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Log In"

      expect(current_path).to eq("/profile") #this need to be updated to meet us13 requirements
    end

    it "a logged in user sees all links and a profile and logout link" do
      user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao")
      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Log In"

      within '.topnav' do
        expect(page).to have_link 'Logout'
        expect(page).to have_link 'Profile'
        expect(page).to have_content("Logged in as #{user.name}")
        expect(page).to_not have_link 'Log In'
        expect(page).to_not have_link 'Register'
      end
    end

    it "shows a 404 error for user when accessing merchant and admin page" do
      user = User.create(email: "funbucket13@gmail.com", password: "test", name: "Mike Dao", role: 0)
      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Log In"

      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/merchants"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    # User Story 7, User Navigation Restrictions
    #
    # As a default user
    # When I try to access any path that begins with the following, then I see a 404 error:
    # - '/merchant'
    # - '/admin'
    # ```

  end
end
