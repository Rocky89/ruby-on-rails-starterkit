Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#home"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        collection do
          post :sign_in, to: "authentication#sign_in"
          post :sign_up, to: "authentication#sign_up"
        end
      end
    end
  end
end
