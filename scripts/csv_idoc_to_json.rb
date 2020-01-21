#!/usr/bin/env ruby
require 'csv'
require 'json'

# Usage:
# ruby scripts/csv_idoc_to_json.rb data/9-2019-prison-data-trimmed.csv data/9-2019-prison-data-trimmed.json pretty

def main
  source_file = ARGV[0]
  destination_file = ARGV[1]
  pretty = ARGV[2]

  if (source_file.nil?) || (destination_file.nil?)
    puts 'Usage: csv_to_json input_file.csv output_file.json'
    exit(1)
  end

  desired_columns = [
    'Date of Birth',
    'Sex',
    'Race',
    'Veteran Status',
    'Current Admission Date',
    'Admission Type',
    'Parent Institution',
    'Projected Mandatory Supervised Release (MSR) Date3',
    'Projected Discharge Date3',
    'Custody Date',
    'Sentence Date',
    'Crime Class',
    'Holding Offense',
    'Sentence Years',
    'Sentence Months',
    'Truth in Sentencing',
  ]

  parsed_csv = []

  CSV.foreach(source_file, headers: true) do |row|
    parsed_csv << parse_idoc_csv_row(
      row: row, desired_columns: desired_columns,
    )
  end

  write_output_json(
    parsed_csv: parsed_csv,
    destination_file: destination_file,
    pretty: pretty,
  )
end

def parse_idoc_csv_row(row:, desired_columns:)
  parsed_row = {}

  desired_columns.each do |column_name|
    unless column_name == 'Sentence Years'
      parsed_row[column_name] = row[column_name]
    else
      if row[column_name] == 'LIFE'
        parsed_row[column_name] = row[column_name]
      else
        parsed_row[column_name] = row[column_name].to_i
      end
    end
  end

  return parsed_row
end

def write_output_json(parsed_csv:, destination_file:, pretty:)
  File.open(destination_file, 'w') do |f|
    if (pretty == 'pretty')
      f.puts JSON.pretty_generate(parsed_csv)
    else
      f.puts JSON.generate(parsed_csv)
    end
  end
end

main()

