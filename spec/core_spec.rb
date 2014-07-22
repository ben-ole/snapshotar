require 'spec_helper'

describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do

      # clear db
      Mongoid.purge!

      # create sample data
      Event.create({name: "Event 1", date: Date.new})
      Event.create({name: "Event 2", date: Date.new})

      # setup configuration
      Snapshotar.configure do |config|

        config.storage_type = :s3

        config.models = []
      end

      @snapshotar = described_class.new
    end

    it "should list snapshots with s3" do
      expect(@snapshotar.list).not_to be_empty
    end

    it "should have one Event" do
      expect(Event.count).to eq 2
    end
  end
end