require "rake"

namespace :snapshotar do

  desc "list available snapshots"
  task list: :environment do

    file = ARGV.last
    task file.to_sym do ; end

    p "# Snapshotar: Listing available snapshots"
    p Snapshotar.list
  end

  desc "create a snapshots"
  task create: :environment do

    file = ARGV.last
    task file.to_sym do ; end

    file = nil if file.downcase == "snapshotar:create"

    p "# Snapshotar: Creating snapshots #{file}"
    p Snapshotar.create(file)
  end

  desc "load a snapshots"
  task load: :environment do

    file = ARGV.last
    task file.to_sym do ; end

    file = nil if file.downcase == "snapshotar:load"

    p "# Snapshotar: Loading snapshot #{file}"
    p Snapshotar.load(file)
  end

  desc "delete a snapshots"
  task delete: :environment do

    file = ARGV.last
    task file.to_sym do ; end

    file = nil if file.downcase == "snapshotar:delete"

    p "# Snapshotar: Listing deleting snapshot #{file}"
    p Snapshotar.delete(file)
  end
end
