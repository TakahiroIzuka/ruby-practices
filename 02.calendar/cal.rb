#!/usr/bin/env ruby

require 'date'
require 'optparse'

# ターゲットの日付は、todayで初期化する
year = Date.today.year
month = Date.today.month

opt = OptionParser.new
# -yオプションで入力された年
opt.on('-y VAL', String) do |y|
  # ターゲット年を上書き
  year = y.to_i
  raise OptionParser::InvalidArgument.new("年は1970~2100の間で設定してください") if target_year < 1970 || 2100 < target_year
end

#-mオプションで入力された月
opt.on('-m VAL') do |m|
  # ターゲット月を上書き
  month = m.to_i
  raise OptionParser::InvalidArgument.new("月は1~12の間で設定してください") if target_month < 1 || 12 < target_month
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

