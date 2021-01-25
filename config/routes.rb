Rails.application.routes.draw do
  resources :users
  # SIDEKIQ
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # AUTH0
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get 'logout', to: 'auth0#logout'
  get 'login', to: 'auth0#login'

  # SUBSCRIPTIONS
  resources :subscriptions
  resources :brands

  # USERS
  get 'profile', to: 'users#profile'

  root 'home#index'
end
