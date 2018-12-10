class Movie
  attr_reader :title, :release_year, :mpaa_rating, :run_time

  def initialize(options)
    @title = options[:movie_title]
    @release_year = options[:release_year]
    @mpaa_rating = options[:mpaa_rating]
    @run_time = options[:run_time]
  end

  def human_readable_run_time
    "#{@run_time / 60}:#{@run_time % 60}"
  end
end
