[![Build Status](https://travis-ci.org/ben-ole/snapshotar.svg?branch=master)](https://travis-ci.org/ben-ole/snapshotar)
[![Code Climate](https://codeclimate.com/github/elchbenny/snapshotar.png)](https://codeclimate.com/github/ben-ole/snapshotar)
[![Gem Version](https://badge.fury.io/rb/snapshotar.svg)](http://badge.fury.io/rb/snapshotar)

# Snapshotar

Make a snapshot of your staging environment and pull back on your dev machine.

## Installation

Add this line to your application's Gemfile:

    gem 'snapshotar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snapshotar

Run install generator:

    $ rails generate snapshotar:install

Lookup *config/initializers/snapshotar.rb* and configure snapshotar.

## What snapshotar can...

1. serializing your rails models to json
2. handling *carrierwave* attachments
3. storing serialized dataset locally or to amazon s3
4. listing available snapshots
5. deserialize snapshot and load back to database

## Why snapshotar?

instead of...

- **database backup?** Because image attachments causing trouble!!
- **fixtures/factories/fakers?** Because this requires coding. Don't spend time coding test data - it's boring.

## When to use snapshotar?

- For testing and development!!
- definitely *NOT* for production backups

## Requirements

- Ruby >= 1.9.3
- tested with *Mongoid*, but *ActiveRecord* should work as well.

## Usage

### rake

    rake snapshotar:create                    # create snapshots
    rake snapshotar:delete                    # delete snapshots
    rake snapshotar:list                      # list available snapshots
    rake snapshotar:load                      # load snapshots

### controller action

You can also integrate snapshotar into your administration backend and let app
users create snapshots. A sample controller is provided below

*app/controllers/admin/snapshots_controller.rb*

    class Admin::SnapshotsController < Admin::AdminController

      def index
        @snapshots = Snapshotar.list
      end

      def load
        Mongoid.purge!
        Snapshotar.load(params[:name])
        redirect_to admin_snapshots_path
      end

      def new
      end

      def create
        Snapshotar.create
        redirect_to admin_snapshots_path
      end

      def delete
        Snapshotar.delete(params[:name])
        redirect_to admin_snapshots_path
      end
    end


## Configuration Options

For **AWS S3**, you have to provide the following ENV variables provisioning your S3 bucket. For development environments look at this wonderful dot-env gem https://github.com/bkeepers/dotenv.

*config/initializers/snapshotar.rb*

    Snapshotar.configure do |config|
      config.storage_type = :s3

      # serialization
      config.models << [<ModelName>, <Attribute1 Symbol>, <Attribute2 Symbol>, :id, :name]

      # shorter ...
      config.models << ([User] + User.fields.keys.map { |x| x.to_sym })

    end


    AWS_ACCESS_KEY_ID=<your id>
    AWS_SECRET_ACCESS_KEY=<your secret>
    AWS_SNAPSHOTAR_BUCKET=<a bucket name>
    AWS_REGION=<e.g. eu-central-1>

**Files**

    config.storage_type = :file

Snapshots are stored in the rails *tmp/* directory

## Testing
This repository is under continuous integration testing on travis-ci.org.

Amazon S3 related functionalities are not tested in CI as an official account at
amazon would be required. AWS S3 tests can be run locally by providing a *.env* file
in the projects root directory with the following keys:

    AWS_ACCESS_KEY_ID=<your id>
    AWS_SECRET_ACCESS_KEY=<your secret>
    AWS_SNAPSHOTAR_BUCKET=<a bucket name>
    AWS_REGION=<e.g. eu-central-1>

    RACK_ENV=test

    S3_ENABLED=true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
