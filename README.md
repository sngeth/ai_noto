# AiNoto
[![BuildStatus](https://travis-ci.org/sngeth/ai_noto.svg?branch=master)](https://travis-ci.org/sngeth/ai_noto)

Ai Noto (Love Notes) lets you quickly send SMS messages from your CLI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ai_noto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ai_noto

## Usage

### Installation
Install via RubyGems above or clone and bundle exec rake install the gem locally. After successful
installation `ainoto` should be an executable binstub (rbenv users may need to do
rbenv rehash).


### Setup your Twilio credentials in your environment
Run

> ainoto init

Then edit the file in your home dir, `.ai_noto.rc.yml`. Make sure to
include proper Twilio credentials

### Set up recipients
In your `.ai_noto.rc.yml` please ensure a default_recipient is filled
in. You may also add specific recipients e.g.:
```
Foo: "+18001234567"
```

### Send a new message
Send a message to Foo:
> ainoto new Foo "Hello World"

If no recipient is specified then it will send a message to
`default_recipient` in config.yml

> ainoto new "hello world!"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sngeth/ai_noto. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

