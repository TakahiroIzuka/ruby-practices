#!/usr/bin/env ruby

require 'date'
require 'optparse'

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

(first_date..last_date).each do |date|
  day = date.day.to_s.rjust(2)
  if date == Date.today
    print "\e[#{RED}m#{day}\e[0m "
  else
    print "#{day} "
  end

  puts if date.saturday?
end
print "\n\n"
