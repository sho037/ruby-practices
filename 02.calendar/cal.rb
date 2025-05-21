#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

options = ARGV.getopts('m:', 'y:')

if options['m'].nil? && options['y']
  puts 'y オプションのみは対応していません'
  return
end

today = Date.today

month = options['m'].nil? ? today.month : options['m'].to_i
year = options['y'].nil? ? today.year : options['y'].to_i

first_date = Date.new(year, month)
last_date = Date.new(year, month, -1)

rows = []

rows.push("      #{month}月 #{year}")
rows.push('日 月 火 水 木 金 土')

row_index = 2
rows[row_index] = '   ' * first_date.wday

(first_date..last_date).each do |date|
  rows[row_index] ||= ''
  is_today = today == date
  day_str = date.day.to_s.rjust(2)
  rows[row_index] += (is_today ? "\e[7m#{day_str}\e[0m" : day_str)
  rows[row_index] += ' '

  row_index += 1 if date.saturday?
end

puts rows
puts if last_date.wday != 0
