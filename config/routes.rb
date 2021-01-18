Rails.application.routes.draw do
  # SIDEKIQ
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # AUTH0
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get 'logout', to: 'auth0#logout'

  # SUBSCRIPTIONS
  resources :brands

  root 'home#index'
end
