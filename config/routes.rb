Rails.application.routes.draw do

  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
