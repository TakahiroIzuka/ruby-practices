#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
shot_count = 0
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    # 10フレーム目は0を入れない
    shots << 0 if shot_count < 18
    shot_count += shot_count < 18 ? 2 : 1
  else
    shots << s.to_i
    shot_count += 1
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

# フラグ用の役
NORMAL = 0
SPARE = 1
STRIKE = 2
DOUBLE = 3

point = 0
frame_count = 0
flag = NORMAL
frames.each do |frame|
  frame_count += 1
  point += frame.sum

  break if frame_count > 10

  # フラグの値によって現在のフレームの値をpointにプラス
  case flag
  when DOUBLE
    point += frame.sum + frame[0]
  when STRIKE
    point += frame.sum
  when SPARE
    point += frame[0]
  end

  flag = if frame[0] == 10
           # 一つ前のflagがSTRIKE以上の場合はDOUBLE
           flag >= STRIKE ? DOUBLE : STRIKE
         elsif frame.sum == 10
           SPARE
         else
           NORMAL
         end
end

p point
