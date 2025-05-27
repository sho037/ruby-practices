#!/usr/bin/env ruby
# frozen_string_literal: true

MAX_COLUMNS = 3

dir_and_files = Dir.glob("*").sort

# 何行必要か
how_many_rows = dir_and_files.length / MAX_COLUMNS
how_many_rows += 1 unless dir_and_files.length % MAX_COLUMNS == 0

# 列ごとの最大文字数
max_num_per_column = []

daf_index = 0
MAX_COLUMNS.times do |index|
  max_num_per_column[index] ||= 0
  how_many_rows.times do
    next unless dir_and_files[daf_index]
    max_num_per_column[index] = dir_and_files[daf_index].length if max_num_per_column[index] < dir_and_files[daf_index].length
    daf_index += 1
  end
end

rows = []
daf_index = 0
MAX_COLUMNS.times do |max_c_index|
  how_many_rows.times do |index|
    next unless dir_and_files[daf_index]
    rows[index] ||= ""
    rows[index] = rows[index] + dir_and_files[daf_index].ljust(max_num_per_column[max_c_index]) + "\t"
    daf_index += 1
  end
end

puts rows
