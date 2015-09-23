Rails.application.routes.draw do

  match '/omniauth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  resources :users

  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :users
  end
end
