require 'spec_helper'

describe Snapshotar::Storage::FileStorage do

  context "local file storage" do

    before(:all) do
      Mongoid.purge!

      # setup configuration
      Snapshotar.configure do |config|

        config.storage_type = :file

        # serialization
        config.models << [Artist, :name, :avatar, :genre]
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

      # # reimport
      @snapshotar.import(filename)

      expect(Artist.count).to eq 1
      expect(Artist.first.avatar.path).not_to be_nil

      # clean up
      @snapshotar.delete(filename)
    end

    it "should encode inheritance" do

      # remove sample artist
      Artist.delete_all

      # create band which inherits from artist
      dreadvibes = Band.create({name: "Dreadvibes", genre: "Reggae'n'Roll"})

      # export
      filename = @snapshotar.export

      # clear db
      Mongoid.purge!

      expect(Artist.count).to eq 0

      # # reimport
      @snapshotar.import(filename)

      expect(Artist.count).to eq 1
      expect(Artist.first.name).to eq "Dreadvibes"
      expect(Artist.first.genre).to eq "Reggae'n'Roll"

      # clean up
      @snapshotar.delete(filename)
    end
  end
end
