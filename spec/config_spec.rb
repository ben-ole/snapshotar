require 'spec_helper'

describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do
      Snapshotar.configure do |config|
        # lets use default values
      end
    end

    it "should load default config" do
      Snapshotar.configuration.should_not be_nil

      Snapshotar.configuration.storage_type.should be :s3
    end

  end
end