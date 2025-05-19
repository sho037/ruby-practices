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

first_date_of_week = first_date.wday
is_this_month = month == today.month && year == today.year
print_stack = []

def convert_day(day, is_today)
  day_ = ''
  day_ += (is_today ? "\e[7m#{day}\e[0m" : day.to_s).rjust(2)
  day_ += ' '
end

# 最初の表示
print_stack.push("      #{month}月 #{year}")
print_stack.push('日 月 火 水 木 金 土')

# 月初めの空白
stack_index = 2
print_stack[stack_index] = ''
(1..first_date_of_week).each do
  print_stack[stack_index] += '   '
end

# 日にち
for_is_today = is_this_month ? today.day : 0
week_index = first_date_of_week
(1..last_date.day).each do |day_index|
  print_stack[stack_index] ||= ''
  print_stack[stack_index] += convert_day(day_index, for_is_today == day_index)

  week_index += 1
  if (week_index % 7).zero?
    stack_index += 1
    week_index = 0
  end
end

puts print_stack
puts if last_date.strftime('%w').to_i != 0
