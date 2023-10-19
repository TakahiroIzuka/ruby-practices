#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

OUTPUT_MAP = {
  'l' => 0,
  'w' => 1,
  'c' => 2
}.freeze

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
  puts "#{outputs[OUTPUT_MAP['l']].rjust(widths[OUTPUT_MAP['l']])}" \
       "#{outputs[OUTPUT_MAP['w']].rjust(widths[OUTPUT_MAP['w']])}" \
       "#{outputs[OUTPUT_MAP['c']].rjust(widths[OUTPUT_MAP['c']])}#{file_name}"
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
    max_width = 8
    widths = []
    widths.push(outputs[OUTPUT_MAP['l']].length >= max_width ? outputs[OUTPUT_MAP['']].length + 1 : max_width - 1)
    widths.push(outputs[OUTPUT_MAP['w']].length >= max_width ? outputs[OUTPUT_MAP['w']].length + 1 : max_width)
    widths.push(outputs[OUTPUT_MAP['c']].length >= max_width ? outputs[OUTPUT_MAP['c']].length + 1 : max_width)

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

  if files.count >= 2
    puts "#{total_line.rjust(widths[OUTPUT_MAP['l']])}#{total_word.rjust(widths[OUTPUT_MAP['w']])}#{total_byte.rjust(widths[OUTPUT_MAP['c']])}total"
  end
end
