require "snapshotar/configuration"
require "snapshotar/version"
require "snapshotar/core"
require "snapshotar/tasks"

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

  def self.core
    @core ||= Core.new
  end

  ##
  # List available snapshots
  #
  def self.list
    self.core.list
  end

  ##
  # Create a snapshot
  #
  def self.create(name = nil)
    self.core.export(name)
  end

  ##
  # Load a snapshot
  #
  def self.load(name)
    self.core.import(name)
  end

  ##
  # Delete a snapshot
  #
  def self.delete(name)
    self.core.delete(name)
  end
end
