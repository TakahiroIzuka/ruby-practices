#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMNS = 3

def get_column_size(files)
  files.size < COLUMNS ? files.size : COLUMNS
end

def get_row_size(files, columns)
  files.size.ceildiv(columns)
end

def create_file_arrays(files, columns, rows)
  file_arrays = []
  columns.times do |n|
    if columns == n + 1
      return file_arrays << files
    elsif rows == 1 || files.size > rows && files.size > (columns - n)
      file_arrays << files.slice!(0...rows)
    else
      file_arrays << files.slice!(0...rows - 1)
    end
  end

  file_arrays
end

files = Dir.glob('*')
max_name_length = files.max_by(&:length)
columns = get_column_size(files)
rows = get_row_size(files, columns)
file_arrays = create_file_arrays(files, columns, rows)

(0...rows).each do |row|
  (0...columns).each do |col|
    file_name = file_arrays[col][row].to_s.ljust(max_name_length.size + 2)
    print file_name
  end
  print "\n"
end
