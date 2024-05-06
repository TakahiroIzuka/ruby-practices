# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = []
  end

  def play(marks)
    shots = Shot.shot_factory(marks)

    prev_frame = nil
    @frames = (1..10).map do |index|
      frame = index == 10 ? LastFrame.new : Frame.new
      3.times do
        break if frame.full? || shots.empty?

        frame.set(shots.shift)
      end

      prev_frame.next_frame = frame if index > 1
      prev_frame = frame
    end
  end

  def score
    sum = 0
    return sum if @frames.empty?

    @frames.each_with_index do |frame, index|
      check_set(frame, index)

      sum += frame.score
      if frame.strike?
        sum += frame.next_frame.first_shot.score + frame.next_frame.second_shot.score
        sum += frame.next_frame.next_frame.first_shot.score if frame.next_frame.strike?
      elsif frame.spare?
        sum += frame.next_frame.first_shot.score
      end
    end

    sum
  end

  private

  def check_set(frame, index)
    raise 'Invalid frame (Processing frame is not full)' if index.zero? && !frame.full?
    raise 'Invalid frame (Next frame is not full)' if !frame.last_frame? && !frame.next_frame.full?
  end
end
