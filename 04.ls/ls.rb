#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_COLUMNS = 3

def main
  dir_and_files = Dir.glob('*').sort

  rows_count = (dir_and_files.length.to_f / MAX_COLUMNS).ceil
  max_str_num = 0
  dir_and_files.each { |daf| max_str_num = daf.length if daf.length > max_str_num }

  puts format_columns_by_row_count(dir_and_files, rows_count, max_str_num)
end

def format_columns_by_row_count(items, rows_count, column_width)
  rows = []
  row_index = 0

  items.each do |item|
    row_index = 0 if (row_index % rows_count).zero?

    rows[row_index] ||= ''
    rows[row_index] += "#{item.ljust(column_width)}\t"
    row_index += 1
  end

  rows
end

main if __FILE__ == $PROGRAM_NAME
