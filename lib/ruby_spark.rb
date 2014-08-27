require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/core'
require 'ruby_spark/tinker'
require 'helpers/configuration'

module RubySpark
  class ConfigurationError < StandardError; end

  extend Configuration

  define_setting :access_token
  define_setting :timeout, 30
end
