require 'csv'
require 'pry'

class CSVTransformer
  def initialize(
    output: File.open(File.expand_path('output/showtimes.txt', './'), 'w'),
    input: CSV.read(File.expand_path('input/movies.csv', './'), headers: true),
    print_results: false,
    start_date: Date.today
  )
    @output = output
    @input = input
    @print_results = print_results
  end

  def transform
  end
end
