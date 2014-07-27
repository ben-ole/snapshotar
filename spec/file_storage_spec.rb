require 'spec_helper'

describe Snapshotar::Storage::FileStorage do

  TMP_DIR = "tmp"

  context "local file storage" do

    before(:all) do
      @fileStorage = described_class.new(TMP_DIR)

      # write a test file
      f = File.open(File.join(TMP_DIR,"test.json"), "w+")
      f.close

    end

    after(:all) do

      # clean up
      File.delete(File.join(TMP_DIR,"test.json"))
    end

    it "should initialize correctly" do
    end

    it "should list objects" do

      expect(@fileStorage.index).not_to be_empty
      expect(@fileStorage.index.count).to eq 1
    end

    it "should show one element" do

      expect(@fileStorage.show(@fileStorage.index.first)).not_to be_nil
    end

    it "should create an element" do

      @fileStorage.create("zz_testdump.json",{"test" => "this is a test object"}.to_json)

      expect(JSON.load(@fileStorage.show(@fileStorage.index.last))).to have_key("test")

      @fileStorage.delete("zz_testdump.json")
    end

  end
end
