# RubySpark

Ruby Gem to make API requests to the [Spark Cloud API](http://docs.spark.io/#/api)

##Obtaining a Spark Core Access Token and Core ID

Assuming at this point you've followed the Spark Core's [Getting Started](http://docs.spark.io/#/start) guides and connected your Core with the Spark Cloud.

Head over to the [Spark Build IDE](https://www.spark.io/build). In the Settings tab you can get your Access Token, and you can fetch your Device ID from the Cores tab. You'll need these both to authenticate your API calls, and the Device ID to direct them.

## Installation

To use this gem, install it with `gem install ruby_spark` or add this line to your Gemfile:

    gem 'ruby_spark'

and install it with `bundle install`

## Usage

Load:

    require 'ruby_spark'

Configure:

    RubySpark.configuration do |config|
      config.auth_token = "very_long_spark_api_auth_token"
    end

Instantiate.

    core = RubySpark::Core.new("semi_long_core_device_id")

Fire away:

    core.digital_write(3, "HIGH")  #=> true or false
    core.digital_read(5)           #=> "HIGH" or "LOW"

    core.analog_write(3, 420)      #=> true or false
    core.analog_read(5)            #=> 0 to 4096


Clearly you'll need to replace "very_long_spark_api_auth_token" and "semi_long_core_device_id" with real values.

## Contributing

Happily accepting contributions. To contribute, fork, develop, add some specs, and pull request.

Note about the specs. All API requests make use of the [VCR](https://github.com/vcr/vcr) gem. To contribute without exposing your Auth Token and Core ID, run the specs with your real authentication, and then find-and-replace your Auth Token and Core ID with fake values in the spec and any VCR cassettes.
