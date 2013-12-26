require 'httparty'

require 'spark/version'
require 'spark/core'
require 'spark/tinker'

module Spark
  class ConfigurationError < StandardError; end

  class << self
    attr_accessor :access_token

    def configuration
      yield self
    end
  end

end
