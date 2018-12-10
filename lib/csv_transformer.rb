require 'optparse'
require 'pry'

options = {}

OptionParser.new do |parser|
  parser.banner = 'Usage: ruby lib/csv_transformer.rb'
  parser.on(
    '-o', '--output FILEPATH', 'Path to output relative to the project directory'
  ) do |val|
    # TODO: Write example file
  end

  parser.on(
    '-i', '--input FILEPATH', 'Path to the CSV file to process'
  ) do |val|
    # TODO: Resolve file, throw error if unresolvable
  end

  parser.on(
    '-p', '--print', 'Print the output file to stdout'
  ) do |val|
    options[:print] = true
  end
end.parse!

puts options[:hello] if options[:hello]
