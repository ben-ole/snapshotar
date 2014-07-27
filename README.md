[![Build Status](https://travis-ci.org/elchbenny/snapshotar.svg?branch=master)](https://travis-ci.org/elchbenny/snapshotar)
[![Code Climate](https://codeclimate.com/github/elchbenny/snapshotar.png)](https://codeclimate.com/github/elchbenny/snapshotar)

**Gem is still under development.**
*Hence, this documentation is preliminary!*

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
2. handling carrierwave/paperclip attachments
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


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
