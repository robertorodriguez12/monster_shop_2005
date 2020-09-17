require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:password)}
  end

  it "can be created as a default user" do
      user = User.create(email: "sammy@gmail.com",
                        password: "pass",
                        role: 0)
      expect(user.role).to eq("regular_user")
      expect(user.regular_user?).to be_truthy
    end
end
