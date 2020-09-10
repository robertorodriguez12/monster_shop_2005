require "rails_helper"

RSpec.describe "Merchant navigation restrictions", type: :feature do
  describe "As a merchant" do
    it "cannot see /admin" do
      user = User.create(email: "penelope",
                         password: "boom",
                         role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/admin"

      expect(page).to have_content("404")
    end

  end
end
