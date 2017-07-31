CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['aws_access_key_id'],
    aws_secret_access_key: ENV['aws_secret_access_key'],
    region:                'us-east-2'
  }
  config.fog_directory  = ENV['aws_bucket']
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

  if Rails.env.test?
    Fog.mock!
    Fog.credentials = config.fog_credentials;
    connection = Fog::Storage.new(provider: 'AWS')
    connection.directories.create(key: ENV['aws_bucket'])
    config.enable_processing = false
  end
end
