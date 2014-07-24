require 'spec_helper'

#:nodoc:
describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do
      Snapshotar.configure do |config|
        # lets use default values
      end
    end

    it "should load default config" do
      expect(Snapshotar.configuration).not_to be_nil

      expect(Snapshotar.configuration.storage_type).to eq :s3
      expect(Snapshotar.configuration.serialize).to be_nil
    end

  end
end
