require 'facets/date'
require_relative 'showing'

class TheaterSchedule
  attr_accessor :weekday_availability, :movies, :schedule
  attr_reader :buffers

  def initialize(buffers: { start: 60, between: 35 })
    # Cleaning/maintenance, as duration in minutes from start/end
    @buffers = buffers
    # Start and end as minutes from midnight
    @weekday_availability = {
      '0' => { start: 630, end: 1410 },
      '1' => { start: 480, end: 1380 },
      '2' => { start: 480, end: 1380 },
      '3' => { start: 480, end: 1380 },
      '4' => { start: 480, end: 1380 },
      '5' => { start: 630, end: 1410 },
      '6' => { start: 630, end: 1410 }
    }
    @movies = []
  end

  def allocate_day(date)
    showings = []
    @movies.each do |movie|
      showings.push(
        movie: movie,
        times: allocate_daily_showings(movie, date)
      )
    end
    { date: date, showings: showings }
  end

  def allocate_daily_showings(movie, date)
    showings = []
    day_availability = @weekday_availability[date.wday.to_s]
    time_left = day_availability[:end]
    while time_left - movie.run_time > day_availability[:start] + buffers[:start]
      times = snap_to_best_start_time(movie.run_time, time_left)
      showings.push(
        Showing.new(date: date, start_time: times[:start], end_time: times[:end], movie: movie)
      )
      time_left = times[:start] - buffers[:between]
    end
    showings.sort_by(&:start_time)
  end

  def snap_to_best_start_time(run_time, end_time, step = 5)
    delta = (end_time - run_time) % step
    end_time -= delta
    { start: end_time - run_time, end: end_time }
  end

  def format_schedule_hash(start = DateTime.now.beginning_of_day, duration = 7)
    @schedule = []
    0.upto(duration - 1) do |days_out|
      @schedule.push(allocate_day(start.advance(days: days_out)))
    end
  end
end
