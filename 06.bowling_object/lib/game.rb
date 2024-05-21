# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = frame_factory
  end

  def play(marks)
    @frames.each.with_index(1) do |frame, current_frame|
      3.times do
        break if frame.full? || marks.empty?

        shot = Shot.new(marks.shift)
        frame.set(shot)
        frame.set(Shot.new('0')) if shot.strike? && current_frame < 10
      end
    end

    @frames.sum(&:score)
  end

  private

  def frame_factory
    prev_frame = nil
    frames = Array.new(10) do |index|
      frame = index.zero? ? LastFrame.new : Frame.new(prev_frame)
      prev_frame = frame
    end

    frames.reverse
  end
end
