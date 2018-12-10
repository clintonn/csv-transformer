class Showing
  attr_accessor :start_time, :end_time
  attr_reader :date, :movie
  def initialize(date:, movie:, start_time:, end_time:)
    @date = date
    @movie = movie
    @start_time = start_time
    @end_time = end_time
  end
    
end
