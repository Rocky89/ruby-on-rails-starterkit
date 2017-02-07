require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  describe 'POST #sign_up' do
    it 'Missing parameters' do
      post :sign_up
      expect(response).to have_http_status(400)
    end
    it 'Missing email parameter' do
      post :sign_up, params: { password: '12345678' }
      expect(response).to have_http_status(400)
    end
    it 'Missing password parameter' do
      post :sign_up, params: { email: 'norbert@forman.com' }
      expect(response).to have_http_status(400)
    end
    it 'Valid parameters - create user' do
      post :sign_up, params: { email: 'norbert@forman.com', password: '12345678' }
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['user'].keys).to contain_exactly('id', 'email', 'auth_token')
    end
    it 'Valid parameters - duplicate email' do
      create(:user)
      post :sign_up, params: { email: 'norbert@forman.com', password: '12345678' }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST #sign_in' do
    it 'Missing parameters' do
      post :sign_in
      expect(response).to have_http_status(400)
    end
    it 'Missing email parameter' do
      post :sign_in, params: { password: '12345678' }
      expect(response).to have_http_status(400)
    end
    it 'Missing password parameter' do
      post :sign_in, params: { email: 'norbert@forman.com' }
      expect(response).to have_http_status(400)
    end
    it 'Valid parameters - user sign in' do
      create(:user)
      post :sign_in, params: { email: 'norbert@forman.com', password: '12345678' }
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['user'].keys).to contain_exactly('id', 'email', 'auth_token')
    end
    it 'Valid parameters - invalid email' do
      create(:user)
      post :sign_in, params: { email: 'n@f.com', password: '12345678' }
      expect(response).to have_http_status(404)
    end
    it 'Valid parameters - invalid password' do
      create(:user)
      post :sign_in, params: { email: 'norbert@forman.com', password: '123' }
      expect(response).to have_http_status(422)
    end
  end
  describe 'POST #forgot_password' do
    it 'Missing parameters' do
      post :forgot_password
      expect(response).to have_http_status(400)
    end
    it 'Valid parameters - invalid email' do
      create(:user)
      post :forgot_password, params: { email: 'n@f.com' }
      expect(response).to have_http_status(404)
    end
    it 'Valid parameters - valid email' do
      create(:user)
      post :forgot_password, params: { email: 'norbert@forman.com' }
      expect(response).to have_http_status(200)
    end
  end
end
