#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMNS = 3
is_all_option = false
is_reverse_option = false

opt = OptionParser.new
opt.on('-a') { is_all_option = true }
opt.on('-r') { is_reverse_option = true }
opt.parse!(ARGV)

def get_column_size(files)
  files.size < COLUMNS ? files.size : COLUMNS
end

def get_row_size(files, columns)
  files.size.ceildiv(columns)
end

def create_file_arrays(files, columns, rows)
  file_arrays = files.each_slice(rows).to_a
  file_arrays.concat(Array.new(columns - file_arrays.size, []))
end

flag = is_all_option ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flag)
sorted_files = is_reverse_option ? files.reverse : files
max_name_length = sorted_files.max_by(&:length)
columns = get_column_size(sorted_files)
rows = get_row_size(sorted_files, columns)
file_arrays = create_file_arrays(sorted_files, columns, rows)

(0...rows).each do |row|
  (0...columns).each do |col|
    file_name = file_arrays[col][row].to_s.ljust(max_name_length.size + 2)
    print file_name
  end
  print "\n"
end
