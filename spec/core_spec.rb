require 'spec_helper'
require 'jbuilder'

#:nodoc:
describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do

      # clear db
      Mongoid.purge!

      # setup configuration
      Snapshotar.configure do |config|

        config.storage_type = :s3

        # custom serialization
        config.snapshot do |json|
          json.array! Event.all, :name, :date
        end

        # auto serialization
        config.models << [Event, :name, :date]
        config.models << [Artist, :name]

      end

      # create sample data
      Event.create({name: "Event 1", date: Date.new})
      Event.create({name: "Event 2", date: Date.new})

      Artist.create({name: "Artist 1"})
      Artist.create({name: "Artist 2"})

      @snapshotar = described_class.new
    end

    it "should list snapshots with s3" do
      expect(@snapshotar.list).not_to be_empty
    end

    it "should have one Event" do
      expect(Event.count).to eq 2
      expect(Artist.count).to eq 2
    end

    it "should correctly read config models" do

      serialized = Jbuilder.encode do |json|
        Snapshotar.configuration.models.each do |m|
          model_name = m.first.name
          json.set! model_name do
            json.array! m.first.all, *m[1..-1]
          end
        end
      end

      # p "serialized: #{serialized}"
    end

    it "should export models" do
      filename = @snapshotar.export
      expect(@snapshotar.list).to include(filename)

      # clean up
      @snapshotar.delete(filename)
    end

    it "should import models" do
      # export sample
      filename = @snapshotar.export

      # clear db
      Mongoid.purge!

      expect(Event.count).to eq 0
      expect(Artist.count).to eq 0

      # reimport
      @snapshotar.import(filename)

      expect(Event.count).to eq 2
      expect(Artist.count).to eq 2

      # clean up
      @snapshotar.delete(filename)
    end
  end
end
