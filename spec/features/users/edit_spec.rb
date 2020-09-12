require "rails_helper"

RSpec.describe "User show page", type: :feature do
  describe "As a user" do
    it "I can Edit my Info" do
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

      click_link "Edit My Info"

      expect(current_path).to eq("/profile/edit")

      fill_in :name, with: "Captain Jack"
      fill_in :street_address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "11111"
      fill_in :email, with: "c_j@email.com"
      fill_in :password, with: user.password
      fill_in :password_confirmation, with: user.password

      click_on "Submit Changes"
      user = User.create(email: "c_j@email.com",
                        password: "test",
                        name: "Captain Jack",
                        street_address: "123 Main Street",
                        city: "Denver",
                        state: "CO",
                        zip: 11111,
                        role: 0)

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Successfully updated your information!")

      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{user.street_address}")
      expect(page).to have_content("#{user.city}")
      expect(page).to have_content("#{user.state}")
      expect(page).to have_content("#{user.zip}")
      expect(page).to have_content("#{user.email}")
    end

    it "User Can Edit their Profile Data" do
      user = User.create(email: "c_j@email.com",
                        password: "test",
                        name: "Captain Jack",
                        street_address: "123 Main Street",
                        city: "Denver",
                        state: "CO",
                        zip: 11111,
                        role: 0)
      visit '/'

      click_on "Login"

      require "rails_helper"
  RSpec.describe "User show page", type: :feature do
    describe "As a user" do
      it "I can Edit my Info" do
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
        expect(page).to have_link("Edit My Password")

        click_link "Edit My Password"

        expect(current_path).to eq("/profile/password")


        expect(page).to have_field(:password)
        expect(page).to have_field(:password_confirmation)

        fill_in :password, with: "test2"
        fill_in :password_confirmation, with: "test2"

        click_on "Save Password"

        expect(current_path).to eq("/profile")
        expect(page).to have_content("Successfully updated your password!")

      end
    end
  end
    end

  end
end
