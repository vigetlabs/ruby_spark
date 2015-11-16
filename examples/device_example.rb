require "bundler/setup"
require "ruby_spark"

device = RubySpark::Device.new(ARGV[0], ARGV[1])

p device.info
p device.function("set", "1")

while true do
  p device.variable("light")
end
