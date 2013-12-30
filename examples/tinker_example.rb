require "bundler/setup"
require "ruby_spark"

core = RubySpark::Tinker.new(ARGV[0], ARGV[1])

p core.info

while true do
  p core.digital_write("6", ["HIGH", "LOW"].sample)
  sleep(3)
end
