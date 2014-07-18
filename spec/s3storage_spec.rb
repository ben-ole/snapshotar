require 'spec_helper'
require 'dotenv'
Dotenv.load

describe Snapshotar::S3Storage do

  context "setup s3 connection" do

    before(:all) do
      @s3Storage = described_class.new
    end

    it "should initialize correctly" do
    end

    it "should list objects" do
      @s3Storage.index.should_not be_empty
    end

    it "should show one element" do
      @s3Storage.show(@s3Storage.index.first).should_not be_nil
    end

    it "should create an element" do
      @s3Storage.create("zz_testdump.json",{test: "this is a test object"}.to_json)

      JSON.load(@s3Storage.show(@s3Storage.index.last)).should have_key("test")

      @s3Storage.delete("zz_testdump.json")
    end

  end
end