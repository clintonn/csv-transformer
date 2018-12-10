require 'csv'
require 'pry'
require_relative 'theater_schedule'
require_relative 'movie'

class CSVTransformer
  def initialize(
    output: File.open(File.expand_path('output/showtimes.txt', './'), 'w'),
    input: CSV.read(File.expand_path('input/movies.csv', './'), headers: true),
    print_results: false,
    start_date: DateTime.now.beginning_of_day,
    duration: 7
  )
    @output = output
    @input = input
    @print_results = print_results
    @theater_schedule = TheaterSchedule.new
    @start_date = start_date
    @duration = duration
  end

  def process_titles
    @input.each do |row|
      @theater_schedule.movies << Movie.new(row_to_hash(row))
    end
  end

  def process_schedule
    @theater_schedule.format_schedule_hash(@start_date, @duration)
  end

  def row_to_hash(row)
    attrs = {}
    row.each do |key, val|
      sym = key.strip.downcase.gsub(/\s/, '_').to_sym
      val.strip!
      val = runtime_to_minutes(val) if sym == :run_time
      attrs[sym] = val
    end
    attrs
  end

  def runtime_to_minutes(runtime_str)
    runtime = runtime_str.strip.match(/(\d+):(\d+)/)
    hours = runtime&.captures&.first
    minutes = runtime&.captures&.last
    hours && minutes ? hours.to_i * 60 + minutes.to_i : nil
  end

  def transform
    process_titles
    process_schedule
  end
end
