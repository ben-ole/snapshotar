module Snapshotar

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
