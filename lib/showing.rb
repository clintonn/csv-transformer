require 'facets/date'

class Showing
  attr_accessor :start_time, :end_time
  attr_reader :date, :movie
  def initialize(date:, movie:, start_time:, end_time:)
    @date = date
    @movie = movie
    @start_time = start_time
    @end_time = end_time
  end

  def human_readable_timeframes
    starting_time = date.beginning_of_day
    "#{starting_time.advance(minutes: start_time).strftime('%H:%M')} - #{starting_time.advance(minutes: end_time).strftime('%H:%M')}"
  end
end
