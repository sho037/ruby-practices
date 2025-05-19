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

print_stack = []

print_stack.push("      #{month}月 #{year}")
print_stack.push('日 月 火 水 木 金 土')

stack_index = 2
print_stack[stack_index] = ''
(1..first_date.wday).each do
  print_stack[stack_index] += '   '
end

is_this_month = month == today.month && year == today.year
(first_date..last_date).each do |day_index|
  print_stack[stack_index] ||= ''
  is_today = is_this_month && today.day == day_index.day
  print_stack[stack_index] += (is_today ? "\e[7m#{day_index.day}\e[0m" : day_index.day.to_s).rjust(2)
  print_stack[stack_index] += " "

  stack_index += 1 if day_index.wday == 6
end

puts print_stack
puts if last_date.wday != 0
