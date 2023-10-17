#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def get_each_total(files, options)
  total_line = 0
  total_word = 0
  total_byte = 0
  files.each do |file|
    total_line += options['l'] ? file[:text].scan(/\n/).length : 0
    total_word += options['w'] ? file[:text].split(/\s+/).length : 0
    total_byte += options['c'] ? file[:text].bytesize : 0
  end
  {
    line_count: total_line.positive? ? "#{total_line} " : '',
    word_count: total_word.positive? ? "#{total_word} " : '',
    byte_count: total_byte.positive? ? "#{total_byte} " : ''
  }
end

def output_wc(outputs, widths, file_name = '')
  puts "#{outputs[0].rjust(widths[0])}#{outputs[1].rjust(widths[1])}#{outputs[2].rjust(widths[2])}#{file_name}"
end

options = ARGV.getopts('l', 'w', 'c')
if options.values.all?(false)
  options['l'] = true
  options['w'] = true
  options['c'] = true
end

files = []
ARGV.each do |file_name|
  text = File.read(file_name)
  files << { file_name:, text: }
end

if files.empty?
  readlines = ARGF.readlines
  line_count = readlines.length
  word_count = 0
  byte_count = 0
  readlines.each do |line|
    word_count += line.split.size
    byte_count += line.size
  end

  outputs = Array.new(2, '')
  outputs.unshift byte_count.to_s if options['c']
  outputs.unshift word_count.to_s if options['w']
  outputs.unshift line_count.to_s if options['l']

  if options.values.count(true) == 1
    puts outputs[0]
  else
    widths = []
    widths.push(outputs[0].length > 7 ? outputs[0].length + 1 : 7)
    widths.push(outputs[1].length > 7 ? outputs[0].length + 1 : 8)
    widths.push(outputs[2].length > 7 ? outputs[0].length + 1 : 8)

    output_wc(outputs, widths)
  end
else
  each_total = get_each_total(files, options)
  total_line = each_total[:line_count]
  total_word = each_total[:word_count]
  total_byte = each_total[:byte_count]

  widths = []
  widths.push(total_line.empty? || (options.values.count(true) == 1 && files.count == 1) ? 0 : total_line.size + 1)
  widths.push(total_word.empty? || (options.values.count(true) == 1 && files.count == 1) ? 0 : total_word.size + 1)
  widths.push(total_byte.empty? || (options.values.count(true) == 1 && files.count == 1) ? 0 : total_byte.size)

  files.each do |file|
    outputs = []
    outputs.unshift options['c'] ? "#{file[:text].bytesize} " : ''
    outputs.unshift options['w'] ? "#{file[:text].split(/\s+/).length} " : ''
    outputs.unshift options['l'] ? "#{file[:text].scan(/\n/).length} " : ''

    output_wc(outputs, widths, file[:file_name])
  end

  puts "#{total_line.rjust(widths[0])}#{total_word.rjust(widths[1])}#{total_byte.rjust(widths[2])}total" if files.count >= 2
end
