require "snapshotar/storage/s3_storage"
require "snapshotar/storage/file_storage"
require "json"
require "jbuilder"

module Snapshotar

  class Core

    def initialize #:nodoc:
      storage_class = Snapshotar::Storage::S3Storage if Snapshotar.configuration.storage_type == :s3
      storage_class = Snapshotar::Storage::FileStorage if Snapshotar.configuration.storage_type == :file

      @storage = storage_class.new
    end

    ##
    # List all available snapshots.
    #
    # returns:: array of filenames
    #
    def list
      @storage.index
    end

    ##
    # Performs a snapshot
    #
    # Params::
    #  +filename+:: filename to create or nil to let snapshotar create something
    # like +snapshotar_dump_<timestamp>.json+
    #
    # returns:: +filename+
    #
    def export(filename = nil)
      filename ||= "snapshotar_dump_#{Time.now.to_i}.json"

      serialized = Jbuilder.encode do |json|
        Snapshotar.configuration.models.each do |m|
          model_name = m.first.name
          json.set! model_name do
            json.array! m.first.all do |itm|
              m[1..-1].each do |attr|

                next unless itm.respond_to?(attr.to_sym)
                next if itm[attr].nil?

                # replace uploads by their url
                if itm.send(attr.to_sym).respond_to?(:url)
                  json.set! "#{attr}_url".to_sym, itm.send(attr.to_sym).url
                else
                  json.set! attr.to_sym, itm[attr]
                end
              end
            end
          end
        end
      end

      @storage.create(filename,serialized)

      return filename
    end

    # Load a snapshot.
    #
    # Params::
    #  +filename+:: name of the snapshot to load
    #
    def import(filename)
      tree = JSON.load @storage.show(filename)

      tree.each do |key,value|
        clazz = key.constantize

        value.each do |itm|
          item_params = {}
          itm.each do |itm_key,itm_value|

            next if itm_value.nil?

            # handle url paths separatley
            if itm_key.to_s.end_with?("_url")
              orig_key = "remote_#{itm_key}"#.to_s[0..-5].to_sym
              item_params[orig_key] = itm_value#File.open(itm_value)
            else
              item_params[itm_key] = itm_value
            end
          end
          p "params: #{item_params}"
          clazz.create(item_params)
        end
      end
    end

    ##
    # delete a snapshot.
    #
    # Params::
    #  +filename+:: name of the snapshot to delete
    #
    def delete(filename)

      @storage.delete(filename)
    end

  end
end
