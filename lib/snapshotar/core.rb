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

      # serialized = Jbuilder.encode{|json| Snapshotar.configuration.serialize.call(json)}
      serialized = Jbuilder.encode do |json|
        Snapshotar.configuration.models.each do |m|
          model_name = m.first.name
          json.set! model_name do
            json.array! m.first.all, *m[1..-1]
          end
        end
      end

      @storage.create(filename,serialized)

      return filename
    end

    def import(filename)
      tree = JSON.load @storage.show(filename)

      tree.each do |key,value|
        clazz = key.constantize
        value.each do |itm|
          clazz.create(itm)
        end
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