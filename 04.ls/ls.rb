#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_COLUMNS = 3

dir_and_files = Dir.glob("*").sort

# 何行必要か
how_many_rows = (dir_and_files.length.to_f / MAX_COLUMNS).ceil

max_str_num = 0
dir_and_files.each { |daf| max_str_num = daf.length if daf.length > max_str_num }

rows = []
daf_index = 0
MAX_COLUMNS.times do
  how_many_rows.times do |index|
    next unless dir_and_files[daf_index]
    rows[index] ||= ""
    rows[index] = rows[index] + dir_and_files[daf_index].ljust(max_str_num) + "\t"
    daf_index += 1
  end
end

puts rows
