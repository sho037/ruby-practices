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
print_stack[stack_index] = '   ' * first_date.wday

(first_date..last_date).each do |date|
  print_stack[stack_index] ||= ''
  is_today = today == date
  print_stack[stack_index] += (is_today ? "\e[7m#{date.day.to_s.rjust(2)}\e[0m" : date.day.to_s.rjust(2))
  print_stack[stack_index] += ' '

  stack_index += 1 if date.saturday?
end

puts print_stack
puts if last_date.wday != 0
