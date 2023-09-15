#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def get_each_total(files, options)
  total_line = 0
  total_word = 0
  total_character = 0
  files.each do |file|
    total_line += options['l'] ? file[:text].scan(/\n/).length : 0
    total_word += options['w'] ? file[:text].split(/\s+/).length : 0
    total_character += options['c'] ? file[:text].length : 0
  end
  {
    lines: total_line != 0 ? "#{total_line} " : '',
    words: total_word != 0 ? " #{total_word} " : '',
    characters: total_character != 0 ? "#{total_character} " : ''
  }
end

options = ARGV.getopts('l', 'w', 'c')
if options.values.all?(false)
  options['l'] = true
  options['w'] = true
  options['c'] = true
end

files = []
ARGV.each do |file_name|
  file = File.open(file_name)
  text = file.read
  files << { file_name:, text: }
  file.close
end

if files.empty?
  lines = 0
  words = 0
  characters = 0
  while line = ARGF.gets
    lines += 1
    words += line.split.size
    characters += line.size
  end
  output_array = Array.new(2, '')
  output_array.unshift characters.to_s if options['c']
  output_array.unshift words.to_s if options['w']
  output_array.unshift lines.to_s if options['l']

  if options.values.count(true) == 1
    puts output_array[0]
  else
    puts "#{output_array[0].rjust(7)}#{output_array[1].rjust(8)}#{output_array[2].rjust(8)}"
  end
else
  each_total = get_each_total(files, options)
  total_lines = each_total[:lines]
  total_words = each_total[:words]
  total_characters = each_total[:characters]

  files.each do |file|
    lines = options['l'] ? "#{file[:text].scan(/\n/).length} " : ''
    words = options['w'] ? "#{file[:text].split(/\s+/).length} " : ''
    characters = options['c'] ? "#{file[:text].length} " : ''

    if files.count == 1 && options.values.count(true) == 1
      puts "#{lines}#{words}#{characters}#{file[:file_name]}"
    else
      puts " #{lines.rjust(total_lines.size)}#{words.rjust(total_words.size)}#{characters.rjust(total_characters.size)}#{file[:file_name]}"
    end
  end

  puts " #{total_lines}#{total_words}#{total_characters}total" if files.count >= 2
end
