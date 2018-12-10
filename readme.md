# CSV Transformer II - The Delimiting

Welcome to the CSV Transformer! This Ruby script takes a CSV file, and outputs a formatted schedule plaintext file, with options to set start dates yourself.

## Setup

This project uses Ruby >= 2.5, but any version above 2.3 should still run.

```sh
git clone https://github.com/clintonn/csv-transformer.git
cd csv-transformer
# If you don't have bundler installed
gem install bundler
bundle
```

## Usage

The CLI can be run using `ruby lib/script.rb`. The script accepts several flags:

```
-i, --input FILEPATH
    CSV to process, relative to the project directory. If not specified, reads input/movies.csv
-o, --output FILEPATH
    Directory for the output text file, relative to the project directory. If not specified, writes to output/showtimes.txt
-s --start-date
    Sets the start date for the output. If not specified, defaults to today
-d --days
    Sets the number of days to print out. Defaults to 7
```

See ya on the big screen! 🍿
