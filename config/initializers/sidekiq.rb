
Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials[:redis_url], size: 1, network_timeout: 5 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials[:redis_url], size: 20, network_timeout: 5 }
end
