require "snapshotar/version"
require "snapshotar/core"

module Snapshotar

  # Configuration
  class << self
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

    def initialize
      @storage_type = :s3
    end

  end

end
