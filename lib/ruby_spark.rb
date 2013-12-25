require 'httparty'

require 'ruby_spark/version'
require 'ruby_spark/client'

module RubySpark

  class << self
    attr_accessor :api_key

    def configuration
      yield self
    end
  end

end
