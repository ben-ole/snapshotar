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

      serialized = Jbuilder.encode{|json| Snapshotar.configuration.serialize.call(json)}

      @storage.create(filename,serialized)

      return filename
    end

    def import(filename)
      tree = deserialize_tree @storage.show(filename)

      tree.flatten.each_with_index do |item,idx|
        clazz = item["clazz"].constantize
        clazz.create(item.except("clazz"))
      end
    end

    def delete(filename)

      @storage.delete(filename)
    end

    private

    def deserialize_tree(serialized_tree)
      JSON.load(serialized_tree)
    end

  end
end