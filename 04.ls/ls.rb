#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMNS = 3
is_all_option = false
is_reverse_option = false
is_long_option = false

opt = OptionParser.new
opt.on('-a') { is_all_option = true }
opt.on('-r') { is_reverse_option = true }
opt.on('-l') { is_long_option = true }
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

def get_each_max_size(files)
  max_size_user_name = 0
  max_size_group_name = 0
  max_size_hard_link = 0
  files.each do |file|
    fs = File.stat(file)
    user_name  = Etc.getpwuid(fs.uid).name
    group_name = Etc.getgrgid(fs.gid).name
    max_size_user_name = user_name.size if user_name.size > max_size_user_name
    max_size_group_name = group_name.size if group_name.size > max_size_group_name
    max_size_hard_link = fs.nlink.to_s.length if fs.nlink.to_s.length > max_size_hard_link
  end
  {
    user_name: max_size_user_name,
    group_name: max_size_group_name,
    hard_link: max_size_hard_link
  }
end

def get_file_type(file_mode)
  file_type_num = format('%06d', file_mode).slice(0, 2)
  case file_type_num
  when '04'
    'd'
  when '10'
    '-'
  when '12'
    '|'
  else
    ''
  end
end

def convert_permission_char(permission_num)
  permission_char = +''
  permission_num.each_char do |char|
    case char
    when '0'
      permission_char << '---'
    when '1'
      permission_char << '--x'
    when '2'
      permission_char << '-w-'
    when '3'
      permission_char << '-wx'
    when '4'
      permission_char << 'r--'
    when '5'
      permission_char << 'r-x'
    when '6'
      permission_char << 'rw-'
    when '7'
      permission_char << 'rwx'
    end
  end
  permission_char
end

flag = is_all_option ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flag)
sorted_files = is_reverse_option ? files.reverse : files
columns = get_column_size(sorted_files)
rows = get_row_size(sorted_files, columns)

if is_long_option
  max_sizes = get_each_max_size(sorted_files)

  sorted_detail_files = []
  sum_block_size = 0
  sorted_files.each do |file|
    fs = File.stat(file)
    file_mode = fs.mode.to_s(8)
    file_type = get_file_type(file_mode)

    permission_num = file_mode.slice(-3, 3)
    permission = convert_permission_char(permission_num)

    user_name  = Etc.getpwuid(fs.uid).name
    group_name = Etc.getgrgid(fs.gid).name
    time_stamp = fs.mtime.strftime('%b %d %H:%M')
    byte_size = fs.size
    sum_block_size += (byte_size.to_f / 1024).ceil

    sorted_detail_files << "#{file_type}#{permission} "\
                           "#{fs.nlink.to_s.rjust(max_sizes[:hard_link])} "\
                           "#{user_name.ljust(max_sizes[:user_name])} "\
                           "#{group_name.ljust(max_sizes[:group_name])} "\
                           "#{byte_size.to_s.rjust(4)} "\
                           "#{time_stamp} "\
                           "#{file}"
  end

  print "total #{sum_block_size}"
  print "\n"

  file_arrays = create_file_arrays(sorted_detail_files, columns, rows)
else
  file_arrays = create_file_arrays(sorted_files, columns, rows)
end

(0...rows).each do |row|
  (0...columns).each do |col|
    max_name_length = file_arrays[col].max_by(&:length)
    file_name = file_arrays[col][row].to_s.ljust(max_name_length.size + 2)
    print file_name
  end
  print "\n"
end
