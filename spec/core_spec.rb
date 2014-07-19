require 'spec_helper'

describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do
      @snapshotar = described_class.new
    end

    it "should list snapshots with s3" do
      @snapshotar.list.should_not be_empty
    end

  end
end