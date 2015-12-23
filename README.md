# RubySpark

Easily control you [Particle](http://particle.io) (formerly Spark) Device with Ruby.

## Obtaining a Particle Access Token and Device ID

Assuming at this point you've followed Particle's [Getting Started](http://docs.particle.io/#/start) guides and connected your Device with the Particle Cloud.

Head over to the [Particle Build IDE](https://www.particle.io/build). In the Settings tab you can get your Access Token, and you can fetch your Device ID from the Devices tab. You'll need these both to authenticate your API calls, and the Device ID to direct them.

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

### Device API

To instantiate a Device, you need to pass it's `device_id`. If you have your `access_token` setup ahead of time using the `config.access_token` then the second argument is optional.

```ruby
device = RubySpark::Device.new("device_device_id")
# or
device = RubySpark::Device.new("device_device_id", "spark_api_access_token")
```

Fire away:

```ruby
device.info                        #=> { info hash }

device.variable("something")       #=> number (for now)
device.function("foo", "argument") #=> number
```

### Tinker API

The tinker class provides `digital_read`, `digital_write`, `analog_read`, and `analog_write` for the default spark device code. This is the same interface as the tinker app.

```ruby
device = RubySpark::Tinker.new("device_device_id")
# or
device = RubySpark::Tinker.new("device_device_id", "spark_api_access_token")
```

Fire away:

```ruby
device.info                      #=> { info hash }

device.digital_write(3, "HIGH")  #=> true or false
device.digital_read(5)           #=> "HIGH" or "LOW"
```

## Contributing

Happily accepting contributions. To contribute, fork, develop, add some specs, and pull request.

Note about the specs. All API requests make use of the [VCR](https://github.com/vcr/vcr) gem. To contribute without exposing your Access Token and Device ID, run the specs with your real authentication, and then find-and-replace your Access Token and Device ID with fake values in the spec and any VCR cassettes.

***

<a href="http://code.viget.com">
  <img src="http://code.viget.com/github-banner.png" alt="Code At Viget">
</a>

Visit [code.viget.com](http://code.viget.com) to see more projects from [Viget.](https://viget.com)
