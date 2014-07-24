require "snapshotar/version"
require "snapshotar/core"

##
# Make a snapshot of your staging environment and pull back on your dev machine.

module Snapshotar

  # Configuration
  class << self

    ##
    # Configuration object. Create a *snapshotar.rb* initializer under
    # config/initializers and add your configuation inside:
    #
    # => Snapshotar.configure do |config|
    # =>    config.storage_type = :s3
    #
    #       config.models << [Event, :name, :date]
    #       config.models << [Artist, :name]
    # => end

    end
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :storage_type
    attr_accessor :serialize
    attr_accessor :models

    def initialize
      @storage_type = :s3
      @serialize = nil
      @models = []
    end

    def snapshot(&block)
      @serialize = block
    end
  end

end
