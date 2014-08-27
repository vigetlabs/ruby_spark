require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/core'
require 'ruby_spark/tinker'
require 'ruby_spark/helpers/configuration'

module RubySpark
  class ConfigurationError < StandardError; end

  include Configuration

  define_setting :access_token
  define_setting :timeout, 30
end
