# What is this?

Analysis and visualization of prison population data from the Illinois Department of Corrections.

Data source:

https://www2.illinois.gov/idoc/reportsandstatistics/Pages/Prison-Population-Data-Sets.aspx.

# Repository organization

### `/scripts`

Ruby scripts used in data transformation and analysis.

* csv_idoc_to_json.rb -- Convert to JSON. Adapted from: https://gist.github.com/enriclluelles/1423950.
* descriptive_stats.rb -- Print descriptive stats about 9-2019-prison-data-trimmed.json.

# Reproduce the final JSON file

1. Download "September 2019 Prison Stock.xls" from IDOC website: https://www2.illinois.gov/idoc/reportsandstatistics/Pages/Prison-Population-Data-Sets.aspx.
2. Export to CSV format; save as `9-2019-prison-data-trimmed.csv`.
3. Manually trim out the first five rows (comments before the header row) and the last 11 rows (footnotes).
4. Run the following from your command line:

```
ruby scripts/csv_idoc_to_json.rb data/9-2019-prison-data-trimmed.csv data/9-2019-prison-data-trimmed.json pretty
```

The above script will:

* Transform to JSON
* Drop columns we don't need for data visualization

See descriptive stats about the JSON data:

```
ruby scripts/descriptive_stats.rb
```