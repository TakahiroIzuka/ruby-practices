#!/usr/bin/env ruby
# frozen_string_literal: true

COLUMNS = 5

def check_columns(directories)
  directories.size < COLUMNS ? directories.size : COLUMNS
end

def get_rows(directories, columns)
  rows = directories.size / columns
  (directories.size % columns).zero? ? rows : rows + 1
end

def create_dir_array(directories, columns, rows)
  column_num = 0
  dir_array = []
  columns.times do
    return dir_array if directories.empty?

    if columns == 1
      return dir_array << directories
    elsif rows == 1 || directories.size > rows && directories.size > (columns - column_num)
      dir_array << directories.slice!(0...rows)
    else
      dir_array << directories.slice!(0...rows - 1)
    end

    column_num += 1
  end
  dir_array
end

directories = Dir.glob('*')
max_name = directories.max_by(&:length)
columns = check_columns(directories)
rows = get_rows(directories, columns)
dir_array = create_dir_array(directories, columns, rows)

(0...rows).each do |row|
  (0...columns).each do |col|
    dir = dir_array[col][row].to_s.ljust(max_name.size + 2)
    print "#{dir} "
  end
  print "\n"
end
