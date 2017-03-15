require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  describe 'GET #index' do
    before(:each) do
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
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET #show' do
    before(:each) do
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
      expect(response).to have_http_status(401)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @user = create(:user)
      @token = TokenService.encode(email: @user.email)
    end
    it 'Valid user' do
      request.headers['token'] = @token
      post :update, params: { id: @user.id, email: 'halcyon@halcyon.com', password: '87654321',
                              old_password: '12345678', old_email: @user.email,
                              has_notifications: false }
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body['user']['email']).not_to be_empty
      expect(body['user']['email']).to eq('halcyon@halcyon.com')
      expect(body['user']['has_notifications']).to eq(false)
    end
  end

  describe 'GET notifications of a user' do
    before(:each) do
      @user = create(:user)
      @user2 = create(:user, email: 'something@else.com')
      @token = TokenService.encode(email: @user.email)
      message = "#{@user2.email} wants to be friends with you"
      Notification.create(user_id: @user.id, notification_id: 1, notification_message: message,
                          action: 'friend request', notified_id: @user2.id)
    end
    it 'User\'s notifications' do
      request.headers['token'] = @token
      get :notifications
      expect(response).to have_http_status(200)
    end
    it 'Missing token from header' do
      get :notifications
      expect(response).to have_http_status(401)
    end
  end
end
