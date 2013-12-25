require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/core'

module RubySpark
  class ApiKeyNotDefinedError < StandardError; end

  class << self
    attr_accessor :api_key

    def configuration
      yield self
    end
  end

end
