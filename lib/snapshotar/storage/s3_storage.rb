require "aws-sdk"

module Snapshotar
  module Storage

    ##
    # This snapshot storage type connects to amazon s3 via *aws-sdk gem*.
    class S3Storage

      def initialize #:nodoc:

        raise ArgumentError, "You should set ENV['AWS_ACCESS_KEY_ID'] to a valid value" unless ENV['AWS_ACCESS_KEY_ID']
        raise ArgumentError, "You should set ENV['AWS_SECRET_ACCESS_KEY'] to a valid value" unless ENV['AWS_SECRET_ACCESS_KEY']
        raise ArgumentError, "You should set ENV['AWS_SNAPSHOTAR_BUCKET'] to a aws bucket name used only for snapshotting" unless ENV['AWS_SNAPSHOTAR_BUCKET']
        raise ArgumentError, "You should set ENV['AWS_REGION'] to the region of your s3 bucket" unless ENV['AWS_REGION']

        p "Running S3 with key: #{ENV['AWS_ACCESS_KEY_ID']}, secret: #{ENV['AWS_SECRET_ACCESS_KEY']}, bucket: #{ENV['AWS_SNAPSHOTAR_BUCKET']}"

        @s3 = AWS::S3.new(
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
          region: ENV['AWS_REGION'])

        @bucket = @s3.buckets[ENV['AWS_SNAPSHOTAR_BUCKET']]
      end

      ##
      # lists available snapshots in this storage.
      #
      # returns:: array of filenames
      #
      def index
        @bucket.objects.map{|obj| obj.key}
      end

      ##
      # loads a snapshot specified by the given +filename+.
      #
      # Params::
      #  +filename+:: name of the snapshot to load
      #
      # returns:: still seralized json
      #
      def show(filename)
        @bucket.objects[filename]
      end

      ##
      # creates a snapshot specified by the given +filename+ with data provided
      #
      # Params::
      #  +filename+:: name of the snapshot to create
      #  +serialized_tree+:: json serialized data
      #
      def create(filename,serialized_tree)
        @bucket.objects[filename].write(serialized_tree)
      end

      ##
      # deletes a snapshot specified by the given +filename+.
      #
      # Params::
      #  +filename+:: name of the snapshot to delete
      #
      def delete(filename)
        @bucket.objects[filename].delete
      end

    end
  end
end
