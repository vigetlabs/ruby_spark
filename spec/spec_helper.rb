require 'rubygems'
require 'bundler/setup'
require 'vcr'

require 'ruby_spark' # and any other gems you need

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    :record                 => :once,
    :allow_playback_repeats => true,
  }
  c.allow_http_connections_when_no_cassette = false
end

RSpec.configure do |config|
  # some (optional) config here
end
