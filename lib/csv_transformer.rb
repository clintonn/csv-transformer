require 'csv'
require 'pry'
require_relative 'theater_schedule'
require_relative 'movie'

class CSVTransformer
  attr_reader :output
  def initialize(
    output: File.open(File.expand_path('output/showtimes.txt', './'), 'w'),
    input: CSV.read(File.expand_path('input/movies.csv', './'), headers: true),
    start_date: DateTime.now.beginning_of_day,
    duration: 7
  )
    @output = output
    @input = input
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

  def write
    @theater_schedule.schedule.each do |day|
      write_day(day)
    end
  end

  def write_day(day)
    @output << "#{day[:date].strftime('%A %-m/%-d/%Y')}\n\n"
    showings = day[:showings]
    showings.each do |showing|
      movie = showing[:movie]
      @output << "#{movie.title} - Rated #{movie.mpaa_rating}, #{movie.human_readable_run_time}\n"
      write_movie_times(showing[:times])
    end
  end

  def write_movie_times(times)
    @output << "\t\t"
    @output << times.map(&:human_readable_timeframes).join("\n\t\t")
    @output << "\n\n"
  end
end
