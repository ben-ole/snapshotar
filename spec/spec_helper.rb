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
end
