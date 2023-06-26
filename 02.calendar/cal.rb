#!/usr/bin/env ruby

require 'date'
require 'optparse'

RED = 31
DEFAULT = 39

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

target_month = Date.new(year, month)
target_month_last_date = Date.new(year, month, -1)
days_in_month = [*Array.new(target_month.wday, ''), *1..target_month_last_date.day]

case target_month.strftime('%B').length
when 3..4
  format_month = "%15s"
when 5..6
  format_month = "%16s"
when 7..8
  format_month = "%17s"
when 9
  format_month = "%18s"
end

printf(format_month, "#{target_month.strftime('%B')} #{target_month.year}")
puts
printf "Su Mo Tu We Th Fr Sa"

color = DEFAULT
days_in_month.each_with_index do |day, i|
  format_day = "%8s"
  if i % 7 == 0
    puts
    format_day = "%7s"
  end

  if !(day.to_s).empty? && Date.new(target_month.year, target_month.month, day) == (Date.today)
    color = RED
    printf(format_day, "\e[#{color}m#{day}")
    # DEFAULTで上書きしないと以後出力される文字色が全てREDで出力されてしまう
    color = DEFAULT
  else
    printf(format_day, "\e[#{color}m#{day}")
  end
end
puts
puts

