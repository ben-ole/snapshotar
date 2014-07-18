require "snapshotar/version"
require "aws-sdk"

module Snapshotar

  class S3Storage

    def initialize

      raise ArgumentError, "You should set ENV['AWS_ACCESS_KEY_ID'] to a valid value" unless ENV['AWS_ACCESS_KEY_ID']
      raise ArgumentError, "You should set ENV['AWS_SECRET_ACCESS_KEY'] to a valid value" unless ENV['AWS_SECRET_ACCESS_KEY']
      raise ArgumentError, "You should set ENV['AWS_SNAPSHOTAR_BUCKET'] to a aws bucket name used only for snapshotting" unless ENV['AWS_SNAPSHOTAR_BUCKET']

      p "Running S3 with key: #{ENV['AWS_ACCESS_KEY_ID']}, secret: #{ENV['AWS_SECRET_ACCESS_KEY']}, bucket: #{ENV['AWS_SNAPSHOTAR_BUCKET']}"

      @s3 = AWS::S3.new(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION'])

      @bucket = @s3.buckets[ENV['AWS_SNAPSHOTAR_BUCKET']]
    end

    def index
      @bucket.objects.map{|obj| obj.key}
    end

    def show(filename)
      @bucket.objects[filename]
    end

    def create(filename,serialized_tree)
      @bucket.objects[filename].write(serialized_tree)
    end

    def delete(filename)
      @bucket.objects[filename].delete
    end

  end

end
