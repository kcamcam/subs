CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials[:digital_ocean_key],
    aws_secret_access_key: Rails.application.credentials[:digital_ocean_secret],
    region: 'nyc3',
    endpoint: 'https://nyc3.digitaloceanspaces.com'
  }
  config.fog_directory = 'subs' # bucket name
  config.fog_public = false
  config.asset_host = 'nyc3.digitaloceanspaces.com'
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  config.enable_processing = false if Rails.env.test?
end
