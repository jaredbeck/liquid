require 'benchmark/ips'
require_relative 'theme_runner'

Liquid::Template.error_mode = ARGV.first.to_sym if ARGV.first
profiler = ThemeRunner.new

# this profiler is for benchmarking render only
profiler_render = ThemeRunner.new
profiler_render.compile_tests

Benchmark.ips do |x|
  x.time = 10
  x.warmup = 5

  puts
  puts "Running benchmark for #{x.time} seconds (with #{x.warmup} seconds warmup)."
  puts

  x.report("parse:") { profiler.compile }
  x.report("render:") { profiler_render.benchmark_render }
  x.report("parse & render:") { profiler.run }
end
