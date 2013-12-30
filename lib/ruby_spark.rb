require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/core'
require 'ruby_spark/tinker'

module RubySpark
  class ConfigurationError < StandardError; end

  class << self
    attr_accessor :access_token

    def configuration
      yield self
    end
  end

end
