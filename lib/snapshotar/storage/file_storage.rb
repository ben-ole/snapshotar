module Snapshotar
  module Storage

    class FileStorage

      ##
      # Use this property to specify the local path where snapshots are stored.
      # Default:: +./tmp/+
      #
      attr_accessor :base_path

      def initialize #:nodoc:
        @base_path = "tmp"
      end

      ##
      # lists available snapshots in this storage.
      #
      # returns:: array of filenames
      #
      def index
        Dir["#{@base_path}/*.json"].map{|p| File.basename(p)}
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
        File.read File.join(@base_path, filename)
      end

      ##
      # creates a snapshot specified by the given +filename+ with data provided
      #
      # Params::
      #  +filename+:: name of the snapshot to create
      #  +serialized_tree+:: json serialized data
      #
      def create(filename,serialized_tree)
        File.open(File.join(@base_path, filename),"w") do |f|
          f.write(serialized_tree)
        end
      end

      ##
      # deletes a snapshot specified by the given +filename+.
      #
      # Params::
      #  +filename+:: name of the snapshot to delete
      #
      def delete(filename)
        File.delete File.join(@base_path, filename)
      end

    end
  end
end
