Rails.application.routes.draw do
  resources :users
  # SIDEKIQ
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # AUTH0
  get 'auth/auth0/callback',  to: 'auth0#callback'
  get 'auth/failure',         to: 'auth0#failure'
  get 'logout',               to: 'auth0#logout'
  get 'login',                to: 'auth0#login'

  # SUBSCRIPTIONS
  resources :subscriptions
  resources :brands
  get 'release/:id', to: 'brands#release'

  # USERS
  get 'profile', to: 'users#profile'

  root 'home#index'
end
