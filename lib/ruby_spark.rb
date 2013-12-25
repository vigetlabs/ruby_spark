require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/core'
require 'ruby_spark/client'

module RubySpark
  class AuthTokenNotDefinedError < StandardError; end

  class << self
    attr_accessor :auth_token

    def configuration
      yield self
    end
  end

end
