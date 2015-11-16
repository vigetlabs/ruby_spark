require "bundler/setup"
require "ruby_spark"

device = RubySpark::Tinker.new(ARGV[0], ARGV[1])

p device.info

while true do
  p device.digital_write("6", ["HIGH", "LOW"].sample)
  sleep(3)
end
