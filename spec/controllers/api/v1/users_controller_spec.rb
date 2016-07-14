require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  describe 'GET #index' do
    before(:all) do
      @user = create(:user)
      @token = TokenService.encode(email: @user.email)
    end
    it 'Display all users' do
      request.headers['token'] = @token
      get :index
      expect(response).to have_http_status(200)
    end
    it 'Missing token from header' do
      get :index
      expect(response).to have_http_status(500)
    end
  end

  describe 'GET #show' do
    before(:all) do
      @user = create(:user)
      @token = TokenService.encode(email: @user.email)
    end
    it 'Display user' do
      request.headers['token'] = @token
      get :show, params: { id: @user.id }
      expect(response).to have_http_status(200)
    end
    it 'Missing token from header' do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status(500)
    end
  end
end
