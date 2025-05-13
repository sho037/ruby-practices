#!/usr/bin/env ruby
require 'optparse'
require 'date'

options = ARGV.getopts('m:', 'y:')

if options["m"].nil? && options["y"]
  puts "y オプションのみは対応していません" 
  return
end

now = Date.today
month = options["m"].to_i
year = options["y"].to_i
month = now.month if month == 0
year = now.year if year == 0
first_day = Date.new(year, month)
last_day = Date.new(year, month, -1)
first_day_of_week = first_day.strftime('%w').to_i
is_this_month = month == now.month ? true : false
print_stack = []

def convert_day(day, space_time, is_today)
  day_length = day.to_s.length
  day_ = ""
  (1..(space_time - day_length)).each do
    day_ += " "
  end
  day_ += is_today ? "\e[7m#{day.to_s}\e[0m" : day.to_s
end

# 最初の表示
print_stack.push("      #{month}月 #{year}")
print_stack.push("日 月 火 水 木 金 土")

# 月初めの空白
print_stack[2] = "  " if first_day_of_week != 0
(2..first_day_of_week).each do
  print_stack[2] += "   "
end

# 日にち
for_is_today = is_this_month ? now.day : 0
stack_index = 2 
week_index = first_day_of_week
(1..last_day.day).each do | day_index |
  print_stack[stack_index] ||= ""
  print_stack[stack_index] += convert_day(day_index, week_index == 0 ? 2 : 3, for_is_today == day_index)
  
  week_index += 1
  if week_index % 7 == 0
    stack_index += 1
    week_index = 0
  end
end

puts print_stack
puts if last_day.strftime('%w').to_i == 6
