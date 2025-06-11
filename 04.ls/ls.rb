#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

MAX_COLUMNS = 3

def main
  options = ARGV.getopts('a')
  dir_and_files = (options['a'] ? Dir.entries('.') : Dir.glob('*')).sort

  puts format_columns(dir_and_files)
end

def format_columns(items)
  rows_count = (items.length.to_f / MAX_COLUMNS).ceil
  column_width = items.map(&:length).max
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
