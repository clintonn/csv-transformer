# CSV Transformer II - The Delimiting

Welcome to the CSV Transformer!

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

The CLI can be run using `ruby lib/csv_transformer.rb`. The script accepts several flags:

```
-i, --input FILEPATH: CSV to process, relative to the project directory. If not specified, reads input/movies.csv
-o, --output FILEPATH: Folder path for the output text file, relative to the project directory. If not specified, writes to output/showtimes.txt
-p --print: Prints output file to stdout
```

See ya on the big screen! 🍿
