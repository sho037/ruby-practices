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

  stat_items = items.map do |item|
    {
      stat: File.stat(item),
      name: item
    }
  end

  stat_items.each_with_index do |item, index|
    rows[index] = [
      convert_to_file_type(item[:stat]) + convert_to_permission(item[:stat].mode.to_s(8).chars.last(3)),
      item[:stat].nlink.to_s,
      Etc.getpwuid(item[:stat].uid).name,
      Etc.getgrgid(item[:stat].gid).name,
      item[:stat].size.to_s,
      item[:stat].birthtime.strftime('%m %d %H:%M'),
      item[:name]
    ]
  end

  rows = indent_list(rows)

  rows.unshift("total #{items.length}")
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
    'nlink' => 0, 'uid.name' => 0, 'gid.name' => 0, 'size' => 0, 'date' => 0
  }

  items.each do |item|
    max_str_num.each_key.with_index do |key, idx|
      max_str_num[key] = [max_str_num[key], item[idx + 1].length].max
    end
  end

  items.map do |item|
    item[1] = item[1].rjust(max_str_num['nlink'])
    item[2] = item[2].ljust(max_str_num['uid.name'] + 1)
    item[3] = item[3].ljust(max_str_num['gid.name'])
    item[4] = item[4].rjust(max_str_num['size'])
    item[5] = item[5].rjust(max_str_num['date'])
    item.join(' ')
  end
end

main if __FILE__ == $PROGRAM_NAME
