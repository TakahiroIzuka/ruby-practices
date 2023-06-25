#!/usr/bin/env ruby
# frozen_string_literal: true

def create_multiple_arrays(line)
  arrays = []
  line.times { arrays.append([]) }
  arrays
end

def add_item_with_order(arrays, directories)
  directories.map.with_index do |directory, i|
    next if directory.start_with?('.')

    line = arrays.length
    line.times do |n|
      arrays[n] << directory if i % line == n
    end
  end
end

LINE = 3

multiple_arrays = create_multiple_arrays(LINE)
add_item_with_order(multiple_arrays, Dir.glob('*'))

multiple_arrays.each do |array|
  array.each do |name|
    print name.ljust(15)
  end
  puts
end
