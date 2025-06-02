#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_COLUMNS = 3

dir_and_files = Dir.glob('*').sort

how_many_rows = (dir_and_files.length.to_f / MAX_COLUMNS).ceil

max_str_num = 0
dir_and_files.each { |daf| max_str_num = daf.length if daf.length > max_str_num }

rows = []
row_index = 0
dir_and_files.each do |daf|
  row_index = 0 if (row_index % how_many_rows).zero?

  rows[row_index] ||= ''
  rows[row_index] = "#{rows[row_index]}#{daf.ljust(max_str_num)}\t"
  row_index += 1
end

puts rows
