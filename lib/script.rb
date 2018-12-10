require 'optparse'
require 'fileutils'
require_relative 'csv_transformer'
options = {}

OptionParser.new do |parser|
  parser.banner = 'Usage: ruby lib/csv_transformer.rb'
  parser.on(
    '-o', '--output FILEPATH', 'Path to output relative to the project directory'
  ) do |val|
    begin
      options[:output] = File.open(File.expand_path(val, './'), 'w')
    rescue Errno::ENOENT
      folder_path = val.match(%r{(.*\/).+.+$})&.captures&.first
      if folder_path
        FileUtils.mkdir_p(File.expand_path(folder_path, './'))
        options[:output] = File.open(File.expand_path(val, './'), 'w')
      else
        puts 'Unable to resolve directory path. Please try again'
      end
    rescue Errno::EACCES
      puts 'You don\'t have access to write to this directory'
      exit
    end
  end

  parser.on(
    '-i', '--input FILEPATH', 'Path to the CSV file to process'
  ) do |val|
    match = val.match(/.+(\..+)$/)
    if match&.captures&.first == '.csv'
      begin
        options[:input] = CSV.read(File.expand_path(val, './'), headers: true)
      rescue Errno::ENOENT
        puts 'Input file not found, please make sure your path name resolves relative to the project path'
        exit
      end
    else
      puts "No CSV input file given"
    end
  end

  parser.on(
    '-s', '--start-date STARTDATE', 'Date to start on in format YYYY-MM-DD or YYYY/MM/DD'
  ) do |val|
    options[:start_date] = DateTime.parse(val)
  rescue ArgumentError
    puts 'Please enter the date in format YYYY-MM-DD or YYYY/MM/DD'
    exit
  end

  parser.on('-d', '--days DAYS', 'Number of days to print out') do |val|
    days = val.to_i
    if days <= 0
      puts 'Invalid number of days given'
      exit
    else
      options[:duration] = days
    end
  end
end.parse!

csvt = CSVTransformer.new(options)
csvt.transform
csvt.write
