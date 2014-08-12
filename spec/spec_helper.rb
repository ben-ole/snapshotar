require 'bundler/setup'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'snapshotar'
require 'mongoid'

Mongoid.load!('spec/config/mongoid.yml')

require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  config.root = Dir.pwd
  config.asset_host = Dir.pwd
end

require 'models/event'
require 'models/artist'


RSpec.configure do |config|

  config.tty = true

  if ENV['S3_ENABLED']=="false"
    p "Skipping S3 Tests"
    config.filter_run_excluding require_s3: true
  end
end
