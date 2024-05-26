# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = Array.new(10) do |index|
      index == 9 ? LastFrame.new(index) : Frame.new(index)
    end
  end

  def play(marks)
    copied_marks = marks.dup
    @frames.each do |frame|
      loop do
        break if frame.full?

        shot = Shot.new(copied_marks.shift)
        frame.set(shot)
      end
    end

    @frames.sum do |frame|
      frame.calc_score(@frames)
    end
  end
end
