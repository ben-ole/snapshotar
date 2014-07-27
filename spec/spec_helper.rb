require 'bundler/setup'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'snapshotar'
require 'mongoid'

Mongoid.load!('spec/config/mongoid.yml')

require 'models/event'
require 'models/artist'

RSpec.configure do |config|

  config.tty = true

  if ENV['S3_ENABLED']=="false"
    p "Skipping S3 Tests"
    config.filter_run_excluding require_s3: true
  end
end
