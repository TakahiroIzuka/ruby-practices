#!/usr/bin/env ruby
# frozen_string_literal: true

SHOT_NUM_UPTO_9FRAMES = 9 * 2
POINT_10 = 10

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0 if shots.size < SHOT_NUM_UPTO_9FRAMES
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
if frames[10]
  frames[9].concat frames[10]
  frames.pop
end

point = 0
frames.each_with_index do |frame, i|
  point += frame.sum

  next if i >= 9

  next_frame = frames[i + 1]
  after_next_frame = frames[i + 2]
  if frame[0] == POINT_10
    point += next_frame[0] + next_frame[1]
    point += after_next_frame[0] if next_frame[0] == POINT_10 && after_next_frame
  elsif frame.sum == POINT_10
    point += next_frame[0]
  end
end

p point
