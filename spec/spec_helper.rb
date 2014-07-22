require 'bundler/setup'
Bundler.setup

require 'dotenv'
Dotenv.load

require 'snapshotar' # and any other gems you need

require 'mongoid'

Mongoid.load!('spec/config/mongoid.yml')

require 'models/event'

RSpec.configure do |config|
  # some (optional) config here
end