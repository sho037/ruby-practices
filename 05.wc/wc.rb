#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l', 'w', 'c')
  files = ARGV.empty? ? gets.chomp.split(/[ \n\t]+/).reject(&:empty?) : ARGV

  infos = files.map { |file_name| WcInfo.summary_from_file_name(file_name) }.compact

  infos.each { |info| puts info.to_s(**opt_parse(options)) }

  total_info = WcInfo.new('total', infos.sum(&:lines), infos.sum(&:words), infos.sum(&:bytes))

  puts total_info.to_s(**opt_parse(options))
end

def opt_parse(options)
  if options.values.any?
    { lines: options['l'], words: options['w'], bytes: options['c'] }
  else
    { lines: true, words: true, bytes: true }
  end
end

class WcInfo
  attr_reader :lines, :words, :bytes

  def self.summary_from_file_name(file_name)
    file = File.open(file_name, 'r:utf-8')
    lines = file.each_line.count
    file.rewind
    words = file.read.encode('UTF-8', invalid: :replace, undef: :replace, replace: '').split(/[ \t\r\n,.]+/).size
    bytes = file.size
    new(file_name, lines, words, bytes)
  rescue Errno::ENOENT
    puts "wc: #{file_name}: open: No such file or directory"
    nil
  rescue StandardError => e
    puts "wc: #{file_name}: open: #{e.class} #{e.message}"
    nil
  end

  def initialize(name, lines, words, bytes)
    @name = name
    @lines = lines
    @words = words
    @bytes = bytes
  end

  def to_s(lines:, words:, bytes:)
    str = ''
    str += format(@lines.to_s) if lines
    str += format(@words.to_s) if words
    str += format(@bytes.to_s) if bytes
    str + " #{@name}"
  end

  private

  def format(str)
    " #{str.rjust(7)}"
  end
end

main if __FILE__ == $PROGRAM_NAME
