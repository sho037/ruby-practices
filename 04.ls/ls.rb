#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

MAX_COLUMNS = 3

def main
  options = ARGV.getopts('a', 'r', 'l')
  dir_and_files = (options['a'] ? Dir.entries('.') : Dir.glob('*')).sort
  dir_and_files.reverse! if options['r']

  puts options['l'] ? format_list(dir_and_files) : format_columns(dir_and_files)
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

def format_list(items)
  rows = []

  stat_items = items.map { |item| { stat: File.stat(item), name: item } }

  blocks_total = 0
  stat_items.each_with_index do |item, index|
    blocks_total += item[:stat].blocks
    rows[index] = {
      mode: convert_to_file_type(item[:stat]) + convert_to_permission(item[:stat].mode.to_s(8).chars.last(3)),
      nlink: item[:stat].nlink.to_s,
      uid_name: Etc.getpwuid(item[:stat].uid).name,
      gid_name: Etc.getgrgid(item[:stat].gid).name,
      size: item[:stat].size.to_s,
      date: item[:stat].birthtime.strftime('%m %d %H:%M'),
      name: item[:name]
    }
  end

  rows = indent_list(rows)

  rows.unshift("total #{blocks_total}")
end

FILE_TYPE = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecial' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's',
  'unknown' => '-'
}.freeze

def convert_to_file_type(item)
  FILE_TYPE[item.ftype]
end

PERMISSION = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def convert_to_permission(items)
  items.map { |num_str| PERMISSION[num_str] }.join
end

def indent_list(items)
  max_str_num = {
    nlink: 0, uid_name: 0, gid_name: 0, size: 0, date: 0
  }

  items.each do |item|
    max_str_num.each_key do |key|
      max_str_num[key] = [max_str_num[key], item[key].length].max
    end
  end

  items.map do |item|
    [item[:mode], item[:nlink].rjust(max_str_num[:nlink]),
     item[:uid_name].ljust(max_str_num[:uid_name] + 1),
     item[:gid_name].ljust(max_str_num[:gid_name] + 1),
     item[:size].rjust(max_str_num[:size]),
     item[:date].rjust(max_str_num[:date]),
     item[:name]].join(' ')
  end
end

main if __FILE__ == $PROGRAM_NAME
