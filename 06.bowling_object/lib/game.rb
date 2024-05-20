# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = frame_factory
  end

  def play(marks)
    shots = Shot.shot_factory(marks)
    @frames.each do |frame|
      3.times do
        break if frame.full? || shots.empty?

        frame.set(shots.shift)
      end
    end

    score
  end

  private

  def score
    sum = 0
    return sum if @frames.empty?

    @frames.each_with_index do |frame, index|
      check_set(frame, index)
      sum += frame.score
    end

    sum
  end

  def frame_factory
    prev_frame = nil
    frames = (1..10).map do |index|
      frame = index == 1 ? LastFrame.new : Frame.new(prev_frame)
      prev_frame = frame
    end

    frames.reverse
  end

  def check_set(frame, index)
    raise 'Invalid frame (Processing frame is not full)' if index.zero? && !frame.full?
    raise 'Invalid frame (Next frame is not full)' if !frame.last_frame? && !frame.next_frame.full?
  end
end
