require "rails_helper"

RSpec.describe "User show page", type: :feature do
  describe "As a visitor" do
    it "can login and see my info except for my password with a link to edit said data" do
      user = User.create(email: "funbucket13@gmail.com",
                        password: "test",
                        name: "Mike Dao",
                        street_address: "123 easy street",
                        city: "Anycity",
                        state: "Anystate",
                        zip: 12345,
                        role: 0)

      visit '/'

      click_on "Login"

      expect(current_path).to eq("/login")

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login to Account"
      expect(current_path).to eq("/profile")
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
      expect(page).to have_link("Edit My Info")
    end
  end
end
