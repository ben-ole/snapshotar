module Snapshotar

  class SnapshotarRailtie < Rails::Railtie
    rake_tasks do
      load "tasks/snapshotar.rb"
    end
  end

end
