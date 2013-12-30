require "bundler/setup"
require "ruby_spark"

core = RubySpark::Core.new(ARGV[0], ARGV[1])

p core.info
p core.function("set", "1")

while true do
  p core.variable("light")
end
