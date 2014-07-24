module Snapshotar
  module Storage

    class StorageTemplate

      def initialize #:nodoc:
      end

      ##
      # lists available snapshots in this storage.
      #
      # returns:: array of filenames
      #
      def index

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

      end

      ##
      # creates a snapshot specified by the given +filename+ with data provided
      #
      # Params::
      #  +filename+:: name of the snapshot to create
      #  +serialized_tree+:: json serialized data
      #
      def create(filename,serialized_tree)

      end

      ##
      # deletes a snapshot specified by the given +filename+.
      #
      # Params::
      #  +filename+:: name of the snapshot to delete
      #
      def delete(filename)

      end

    end
  end
end
