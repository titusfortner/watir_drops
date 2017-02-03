# WatirDrops

[![Gem Version](https://badge.fury.io/rb/watir_drops.svg)](http://badge.fury.io/rb/watir_drops)
[![Travis Status](https://travis-ci.org/titusfortner/watir_drops.svg?branch=master)](https://travis-ci.org/titusfortner/watir_drops)

This gem leverages the Watir test framework to allow for easy modeling of specific web application information, 
allowing it to be decoupled from the tests.
The intention is to provide a solution that is easy to use and maintain, while still providing power and flexibility.

## Usage

Create a class that represents a unique page or modal on your site and have it inherit WatirDrops.

Please see [spec/on_test_page.rb](spec/on_test_page.rb) for an example.

Once you have created the representation of the page, your automated test can manipluate the page object.

Please see [spec/watir_drops_spec.rb](spec/watir_drops_spec.rb) for examples.

WatirDrops is written to accept several different ways to model test data. 

Please see [spec/form_filling_spec.rb](spec/form_filling_spec.rb) for examples.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'watir_drops'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install watir_drops
    
To use this library:

```ruby
require 'watir_drops'
```


## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/titusfortner/watir_drops)


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
