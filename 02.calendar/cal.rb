#!/usr/bin/env ruby
# encoding: utf-8

require 'date'
require 'optparse'
require 'debug'

RED = 31

year = Date.today.year
month = Date.today.month

opt = OptionParser.new
opt.on('-y VAL', String) do |y|
  year = y.to_i
end

opt.on('-m VAL') do |m|
  month = m.to_i
end

opt.parse!(ARGV)

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

print "#{first_date.strftime('%B')} #{first_date.year}".center(21)
puts

puts 'Su Mo Tu We Th Fr Sa'
print '   ' * first_date.wday

(first_date..last_date).each.with_index do |date, i|
  puts if date.sunday? && i > 0

  day = date.day.to_s.rjust(2)
  if date == Date.today
    print "\e[#{RED}m#{day}\e[0m "
  else
    print "#{day} "
  end
end
print "\n\n"
