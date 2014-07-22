require 'spec_helper'

describe Snapshotar::Storage::S3Storage do

  context "setup s3 connection" do

    before(:all) do
      @s3Storage = described_class.new
    end

    it "should initialize correctly" do
    end

    it "should list objects" do
      expect(@s3Storage.index).not_to be_empty
    end

    it "should show one element" do
      expect(@s3Storage.show(@s3Storage.index.first)).not_to be_nil
    end

    it "should create an element" do
      @s3Storage.create("zz_testdump.json",{"test" => "this is a test object"}.to_json)

      expect(JSON.load(@s3Storage.show(@s3Storage.index.last))).to have_key("test")

      @s3Storage.delete("zz_testdump.json")
    end

  end
end