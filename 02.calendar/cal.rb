#!/usr/bin/env ruby

require 'date'
require 'optparse'

year = Date.today.year
month = Date.today.month

opt = OptionParser.new
opt.on('-y VAL', String) do |y|
  year = y.to_i
end

opt.on('-m VAL') do |m|
  month = m.to_i
end

# parseしないとopt.onのブロックが実行されないので注意
opt.parse!(ARGV)

target_month = Date.new(year, month)
target_month_last_date = Date.new(year, month, -1)
days_in_month = (1..target_month_last_date.day.to_i).to_a

(target_month.wday).times do
  days_in_month.unshift('')
end

RED = 31
DEFAULT = 39
printf("%14s", "#{target_month.strftime('%B')} #{target_month.year}")
puts
printf("%13s", "Su Mo Tu We Th Fr Sa")
days_in_month.length.times do |i|
  color = DEFAULT
  format = "%8s"

  if i % 7 == 0
    puts
    format = "%7s"
  end
  color = RED if !(days_in_month[i].to_s).empty? && Date.new(target_month.year, target_month.month, days_in_month[i]) == Date.today
  printf(format, "\e[#{color}m#{days_in_month[i]}")
end
puts
puts

