#!/usr/bin/env ruby
require 'json'
require 'pp'

f = File.read('./data/9-2019-prison-data-trimmed.json')

data = JSON.parse(f)

puts "Rows of data: #{data.size}"

columns = [
  'Sex',
  'Race',
  'Veteran Status',
  'Admission Type',
  'Crime Class',
]

columns.each do |column|
  grouped = data.group_by { |i| i[column] }
  to_counts = grouped.map { |k,v| [k, v.size] }.to_h

  puts
  puts "#{column}:"
  pp to_counts
end