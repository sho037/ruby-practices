#!/usr/bin/env ruby
require 'optparse'
require 'date'

options = ARGV.getopts('m:', 'y:')

month = options["m"]
year = options["y"]

now = Date.today
if month.nil? && year
  puts "y オプションのみは対応していません"
  return
elsif month.nil? && year.nil?
  month = now.month
  year = now.year
else
  month = month.to_i
  year = now.year
end

first_item = []
first_item.push("\t#{month}月 #{year}")
first_item.push("日 月 火 水 木 金 土")

first_day = Date.new(year, month)
last_day = Date.new(year, month, -1)

puts first_item

first_day_of_week = first_day.strftime('%w').to_i

def convert_day(day, space_time)
  day_length = day.to_s.length
  day_ = ""
  (1..(space_time - day_length)).each do
    day_ += " "
  end
  day_ += day.to_s
end

print "  "
(2..first_day_of_week).each do
  print "   "
end

week_index = first_day_of_week

(1..last_day.day).each do | day_index |
  print convert_day(day_index, 3) if week_index != 0
  print convert_day(day_index, 2) if week_index == 0
  
  week_index += 1
  if week_index % 7 == 0
    puts
    week_index = 0
  end
end
