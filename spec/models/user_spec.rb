require "rails_helper"

RSpec.describe User, type: :model do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  describe User do
    it "valid user" do
      create(:user).should be_valid
    end
    it "invalid user - missing email" do
      expect{ create(:user, email: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "invalid user - missing password" do
      expect{ create(:user, password: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "invalid user - missing email & password" do
      expect{ create(:user, email: nil, password: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
