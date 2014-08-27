# RubySpark

Ruby Gem to make API requests to the [Spark Cloud API](http://docs.spark.io/#/api)

## Obtaining a Spark Core Access Token and Core ID

Assuming at this point you've followed the Spark Core's [Getting Started](http://docs.spark.io/#/start) guides and connected your Core with the Spark Cloud.

Head over to the [Spark Build IDE](https://www.spark.io/build). In the Settings tab you can get your Access Token, and you can fetch your Device ID from the Cores tab. You'll need these both to authenticate your API calls, and the Device ID to direct them.

## Installation

To use this gem, install it with `gem install ruby_spark` or add this line to your Gemfile:

```ruby
gem 'ruby_spark'
```

and install it with `bundle install`

## Usage

Load:

```ruby
require 'ruby_spark'
```

Configure:

```ruby
# config/initializers/ruby_spark.rb

RubySpark.configuration do |config|
  config.access_token = "spark_api_access_token"
  config.timeout      = 10.seconds # defaults to 30 seconds
end
```

### Core API

To instantiate a Core, you need to pass it's `device_id`. If you have your `access_token` setup ahead of time using the `config.access_token` then the second argument is optional.

```ruby
core = RubySpark::Core.new("core_device_id")
# or
core = RubySpark::Core.new("core_device_id", "spark_api_access_token")
```

Fire away:

```ruby
core.info                        #=> { info hash }

core.variable("something")       #=> number (for now)
core.function("foo", "argument") #=> number
```

### Tinker API

The tinker class provides `digital_read`, `digital_write`, `analog_read`, and `analog_write` for the default spark core code. This is the same interface as the tinker app.

```ruby
core = RubySpark::Tinker.new("core_device_id")
# or
core = RubySpark::Tinker.new("core_device_id", "spark_api_access_token")
```

Fire away:

```ruby
core.info                      #=> { info hash }

core.digital_write(3, "HIGH")  #=> true or false
core.digital_read(5)           #=> "HIGH" or "LOW"
```

## Contributing

Happily accepting contributions. To contribute, fork, develop, add some specs, and pull request.

Note about the specs. All API requests make use of the [VCR](https://github.com/vcr/vcr) gem. To contribute without exposing your Access Token and Core ID, run the specs with your real authentication, and then find-and-replace your Access Token and Core ID with fake values in the spec and any VCR cassettes.
