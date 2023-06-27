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

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

case first_date.strftime('%B').length
when 3..4
  format_month = '%15s'
when 5..6
  format_month = '%16s'
when 7..8
  format_month = '%17s'
when 9
  format_month = '%18s'
end

printf(format_month, "#{first_date.strftime('%B')} #{first_date.year}")
puts

printf 'Su Mo Tu We Th Fr Sa'
puts if first_date.wday > 0
printf "#{[*Array.new(first_date.wday, '   ')].join}"

color = DEFAULT
(first_date..last_date).each do |date|
  format_day = '%7s '
  puts if date.sunday?

  if date == Date.today
    color = RED
    printf(format_day, "\e[#{color}m#{date.day}")

    # DEFAULTで上書きしないと以後出力される文字色が全てREDで出力されてしまう
    color = DEFAULT
  else
    printf(format_day, "\e[#{color}m#{date.day}")
  end
end
print "\n\n"
