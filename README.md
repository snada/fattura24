# Fattura24

[![Build Status](https://travis-ci.org/snada/fattura24.svg?branch=master)](https://travis-ci.org/snada/fattura24)
[![Maintainability](https://api.codeclimate.com/v1/badges/8db0d6f2c8e567f09319/maintainability)](https://codeclimate.com/github/snada/fattura24/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/8db0d6f2c8e567f09319/test_coverage)](https://codeclimate.com/github/snada/fattura24/test_coverage)

Simple, lightweight and with minimal dependencies ruby 2 wrapper for the [Fattura24](https://www.fattura24.com/) apis.

Tested and developed on rubies 2.4+.

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
# This method checks if your key is valid
response = Fattura24::Api.test_key

# Check for possible network errors, returns true on ok (200) responses
puts response.success?

# Call .to_h to get a hash version of the xml response
puts response.to_h[:returnCode]

# If you need more info, check the raw Net::HTTP response object
raw_response = response.http_response
```

### Api calls

You can take inspiration on the params to provide to your calls by visiting the [official documentation](https://www.fattura24.com/api-documentazione/).
Generally speaking, this library will translate the structure of your hash to an equivalent xml document camelizing all of your keys.

#### TestKey, GetTemplate, GetPdc, GetNumerator

All of these calls don't require any argument. Simply call them and inspect their response:

```ruby
r = Fattura24::Api.test_key
r = Fattura24::Api.get_template
r = Fattura24::Api.get_pdc
r = Fattura24::Api.get_numerator

puts r.to_h
```

#### SaveCustomer

```ruby
r = Fattura24::Api.save_customer(
  customer_name: 'John Doe',
  customer_address: '100 Yonge Street',
  customer_city: 'Toronto',
  customer_country: 'CA',
  customer_fiscal_code: 'Set this for persons',
  customer_vat_code: 'vat',
  customer_email: 'some@email.com',
  fe_customer_pec: 'a@pec.com'
)
```

#### SaveDocument

```ruby
r = Fattura24::Api.save_document(
  document_type: Fattura24::DocumentType::ELECTRONIC_INVOICE,
  customer_name: 'John Doe',
  customer_fiscal_code: 'NDASFN89A27L219Y',
  customer_address: '100 Yonge Street',
  customer_city: 'Toronto',
  customer_country: 'CA',
  payments: [
    {
      date: '2020-04-27',
      amount: '100',
      paid: 'true'
    }
  ],
  rows: [
    {
      code: '001',
      description: 'Element description',
      qty: '1',
      price: '100'
    }
  ],
  id_template: '65',
  send_email: 'true',
  object: 'test',
  total: 100,
  total_without_tax: 100,
  vat_amount: 0
)
```

#### GetFile

```ruby
r = Fattura24::Api.get_file('1234567')

# true if response content is actually a file
if r.pdf?
  File.write('invoice.pdf', r.to_s)
end
```

#### GetProduct

```ruby
# gets all products
r = Fattura24::Api.get_product

# filters by code
r = Fattura24::Api.get_product(code: 'some_code')

# filters by category
r = Fattura24::Api.get_product(category: 'some_category')

# combines both
r = Fattura24::Api.get_product({
  code: 'some_code',
  category: 'some_category'
})
```

## Development

After checking out the repo, run `bundle` to install dependencies. You can run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To run tests and linting, simply run `bundle exec rake`.

When you edit something, include appropriate docs and rebuild them by running `bundle exec rake rdoc`.

If you have docker installed, you can test against all of the supported ruby versions by running:

```bash
$ make build
```

That will build the required docker images, and then you can run tests with:

```bash
$ make
```

### Release of a new version

To release a new version, update the version number in `lib/fattura24/version.rb`. Make sure version tests are still satisfied.
Then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Everyone is welcome to contribute.
This project tries to follow the git-flow branching model. Open a branch named `feature/<name>` and make a PR against `develop`.

Please, make sure you include appropriate unit tests to the codebase (also check coverage) and that your code satisfies rubocop checks.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
