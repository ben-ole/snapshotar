require 'spec_helper'

#:nodoc:
describe Snapshotar::Core do

  context "listing snapshots" do

    before(:all) do
      Snapshotar.configure do |config|
        # lets use default values
        config.storage_type = :file
        config.models = []
      end
    end

    it "should load default config" do
      expect(Snapshotar.configuration).not_to be_nil

      expect(Snapshotar.configuration.storage_type).to eq :file
      expect(Snapshotar.configuration.models).to be_empty
    end

  end
end
