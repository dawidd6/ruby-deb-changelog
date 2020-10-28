# ruby-deb-changelog

A Ruby gem for parsing Debian changelog files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-deb-changelog'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-deb-changelog

## Usage

```ruby
require "deb-changelog"

changelog = DebChangelog.parse_file("./debian/changelog")
puts changelog.methods
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dawidd6/ruby-deb-changelog.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
