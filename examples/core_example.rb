require "bundler/setup"
require "spark"

core = Spark::Core.new(ARGV[0], ARGV[1])

p core.info
p core.function("set", "1")

while true do
  p core.variable("light")
end
