require 'spec_helper'
require 'jbuilder'

describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do

      # clear db
      Mongoid.purge!

      # setup configuration
      Snapshotar.configure do |config|

        config.storage_type = :s3

        config.snapshot do |json|
          json.array! Event.all, :name, :date
        end
      end

      # create sample data
      Event.create({name: "Event 1", date: Date.new})
      Event.create({name: "Event 2", date: Date.new})


      @snapshotar = described_class.new
    end

    it "should list snapshots with s3" do
      expect(@snapshotar.list).not_to be_empty
    end

    it "should have one Event" do
      expect(Event.count).to eq 2
    end

    it "should correctly read config models" do
      expected_output = "[{\"name\":\"Event 1\",\"date\":\"-4712-01-01\"},{\"name\":\"Event 2\",\"date\":\"-4712-01-01\"}]"
      expect(Jbuilder.encode{|json| Snapshotar.configuration.serialize.call(json)}).to eq expected_output
    end

    it "should export models" do
      filename = @snapshotar.export
      expect(@snapshotar.list).to include(filename)

      # clean up
      @snapshotar.delete(filename)
    end
  end
end