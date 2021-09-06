require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# unless Rails.env.development? || Rails.env.test?
CarrierWave.configure do |config|
  config.asset_host = 'http://localhost:3000'

  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: ENV['REGION']
  }

  config.fog_directory  = ENV["FOG_DIRECTORY"]
  config.fog_provider = 'fog/aws'
  config.cache_storage = :fog
end