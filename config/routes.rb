Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  apipie

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#home'

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :sign_in, to: 'authentication#sign_in'
          post :sign_up, to: 'authentication#sign_up'
          post :forgot_password, to: 'authentication#forgot_password'
          get :notifications
        end
      end
      resources :device_tokens, only: [:create]
    end
  end
end
