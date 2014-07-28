require "snapshotar/version"
require "snapshotar/core"

##
# Make a snapshot of your staging environment and pull back on your dev machine.

module Snapshotar

  class << self

    ##
    # Configuration object. Create a *snapshotar.rb* initializer under
    # config/initializers and add your configuation inside:
    #
    #    Snapshotar.configure do |config|
    #      config.storage_type = :file # :s3
    #
    #      config.models << [Event, :name, :date]
    #      config.models << [Artist, :name]
    #    end
    attr_accessor :configuration

  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  ##
  # Configuration Class
  class Configuration

    ##
    # Where to store your snapshots?
    # - +:s3+ for amazon s3 service
    # - +:file+ local directory
    attr_accessor :storage_type

    ##
    # Provide the models and their attributes to seralize like this:
    #    [[ModelName1, :attribute1, :attribute2,...],[ModelName2, :attribute1]]
    #
    attr_accessor :models

    def initialize #:nodoc:
      @storage_type = :file
      @models = []
    end
  end

end
