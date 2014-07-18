require 'spec_helper'
require 'dotenv'
Dotenv.load

describe Snapshotar::S3Storage do
  context "setup s3 connection" do

    before do
      @s3Storage = described_class.new
    end

    it "should initialize correctly" do
    end

    it "should list objects" do
      @s3Storage.list
    end

  end
end