require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  describe "As a visitor" do
    it "can create new user" do

      visit '/items'

      within '.topnav' do
        click_link "Register"
      end

      expect(current_path).to eq('/register')

      fill_in :name, with: "Captain Jack"
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "submit"
      expect(current_path).to eq('/profile')
      expect(page).to have_content('You are now registered and logged in!')
    end

    it "can display error message" do
      visit '/items'

      within '.topnav' do
        click_link "Register"
      end

      expect(current_path).to eq('/register')

      fill_in :name, with: "Captain Jack"
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: ""
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "submit"
      expect(current_path).to eq('/register')
      expect(page).to have_content("You are missing fields, please fill in all fields to register!")
    end

    it "displays flash message saying email is duplicate" do

      user = User.create(email: "c_j@email.com", password: "test", name: "Mike Dao")

      visit '/items'

      within '.topnav' do
        click_link "Register"
      end

      expect(current_path).to eq('/register')

      fill_in :name, with: "Don Juan"
      fill_in :street_address, with: "124 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "submit"
      expect(current_path).to eq('/register')
      expect(page).to have_content("This email is already in use! Please try again!!")
    end
  end
end
