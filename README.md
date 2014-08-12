[![Build Status](https://travis-ci.org/elchbenny/snapshotar.svg?branch=master)](https://travis-ci.org/elchbenny/snapshotar)
[![Code Climate](https://codeclimate.com/github/elchbenny/snapshotar.png)](https://codeclimate.com/github/elchbenny/snapshotar)
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

## What snapshotar can...

1. serializing your rails models to json
2. handling *carrierwave* attachments
3. storing serialized dataset locally or to amazon s3
4. listing available snapshots
5. deserialize snapshot and load back to database

## Why snapshotar?

instead of...

- **database backup?** Because image attachments causing trouble!!
- **fixtures/factories/fakers?** Because this requires coding. Let the
others fill up your app with sample data.

## When to use snapshotar?

- For testing and development!!
- definitely *NOT* for production backups

## Requirements

- Ruby >= 1.9.3
- Rails ?

## Usage

- one option for snapshotar is **rake**

- you can also integrate snapshotar into your administration backend and let app
users create snapshots.

## Configuration Options

## Testing
This repository is under continuous integration testing on travis-ci.org.

Amazon S3 related functionalities are not tested in CI as an official account at
amazon would be required. AWS S3 tests can be run locally by providing a *.env* file
in the projects root directory with the following keys:

    AWS_ACCESS_KEY_ID=<your id>
    AWS_SECRET_ACCESS_KEY=<your secret>
    AWS_SNAPSHOTAR_BUCKET=<a bucket name>

    RACK_ENV=test

    S3_ENABLED=true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
