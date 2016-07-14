require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  describe User do
    it 'valid user' do
      create(:user).should be_valid
    end
    it 'invalid user - missing email' do
      user = build(:user, email: nil)
      expect(user.save).to eq(false)
    end
    it 'invalid user - missing password' do
      user = build(:user, password: nil)
      expect(user.save).to eq(false)
    end
    it 'invalid user - missing email & password' do
      user = build(:user, email: nil, password: nil)
      expect(user.save).to eq(false)
    end
  end
end
