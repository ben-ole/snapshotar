require "snapshotar/version"

module Snapshotar

  class S3Storage

    def initialize
      @s3 = AWS::S3.new(
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])

      @bucket = s3.buckets[ENV['AWS_SNAPSHOTAR_BUCKET']]
    end

    def list

    end

  end

end
