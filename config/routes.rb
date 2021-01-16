Rails.application.routes.draw do
  get 'home/index'

  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
