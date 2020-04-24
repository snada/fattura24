# Fattura24

Simple, lightweight and with minimal dependencies ruby 2 wrapper for the [Fattura24](https://www.fattura24.com/) apis.

Tested and developed on rubies 2.4+, should be simple enough to work on older versions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fattura24'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fattura24

## Usage

First, configure the module by adding your api key.

```ruby
Fattura24.configure do |configuration|
  configuration.api_key = 'your_secret_key'
end
```

Once set, you can call the api methods to get the responses you need.

```ruby
response = Fattura24::Api.test_key

# Check for possible network errors, returns true on ok (200) responses
puts response.success?

# Call .to_h to get a hash version of the xml response
puts response.to_h[:returnCode]

# If you need more info, check the raw Net::HTTP response object
raw_response = response.http_response
```

Beware, this will not validate your api key by triggering the appropriate api endpoint. You are required to explicitly call the appropriate method if you want to check the status of your token.

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Release of a new version

To release a new version, update the version number in `version.rb`, and `lib/fattura24/version`. Make sure version tests are still satisfied.
Then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Everyone is welcome to contribute.
This project tries to follow the git-flow branching model. Open a branch named `feature/<name>` and make a PR against `develop`.

Please, make sure you include appropriate unit tests to the codebase (also check coverage) and that your code satisfies rubocop checks.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
