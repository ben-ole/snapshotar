require 'spec_helper'

describe Snapshotar::Storage::FileStorage do

  context "local file storage" do

    before(:all) do
      Mongoid.purge!

      # setup configuration
      Snapshotar.configure do |config|

        config.storage_type = :file

        # serialization
        config.models << [Artist, :name, :avatar]
      end

      # create models with images attached
      artist = Artist.create({name: "Artist 3"})
      artist.avatar.store!(File.open("snapshotar.png"))
      artist.save

      @snapshotar = Snapshotar::Core.new
    end

    after(:all) do
      # clean up files
      FileUtils.rm_rf(Dir["tmp"])

      Mongoid.purge!
    end

    it "should create image models" do
      expect(Artist.count).to eq 1
      p Artist.first.avatar.path
    end

    it "should export successfully" do
      filename = @snapshotar.export

      expect(@snapshotar.list).to include(filename)

      # clean up
      @snapshotar.delete(filename)
    end

    it "should reimport with images" do
      # export sample
      filename = @snapshotar.export

      # clear db
      Mongoid.purge!

      expect(Artist.count).to eq 0

      # reimport
      @snapshotar.import(filename)

      expect(Artist.count).to eq 1
      p Artist.first.avatar

      # clean up
      @snapshotar.delete(filename)
    end
  end
end
