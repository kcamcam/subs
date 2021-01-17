Rails.application.routes.draw do
  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # AUTH0
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  get 'logout', to: 'auth0#logout'

  root 'home#index'
end
