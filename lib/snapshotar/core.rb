require "snapshotar/storage/s3_storage"

module Snapshotar
  class Core

    def initialize
      storage_class = Snapshotar::Storage::S3Storage if Snapshotar.configuration.storage_type == :s3

      @storage = storage_class.new
    end

    def list
      @storage.index
    end

    def export
      filename = "snapshotar_dump_#{Time.now.to_i}.json"

      #TODO: call json builder in Snapshotar.config


      @storage.create(filename,serialize_tree({"test" => "this is a test object"}))

      return filename
    end

    def import(filename)
      tree = deserialize_tree @storage.show(filename)

      tree.flatten.each_with_index do |item,idx|
        clazz = item["clazz"].constantize
        clazz.create(item.except("clazz"))
      end
    end

    private

    def serialize_tree(tree)
      tree.to_json
    end

    def deserialize_tree(serialized_tree)
      JSON.load(serialized_tree)
    end

  end
end