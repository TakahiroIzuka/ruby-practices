# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = Array.new(10) do |index|
      index == 9 ? LastFrame.new : Frame.new
    end
  end

  def play(marks)
    index = 0
    @frames.each do |frame|
      3.times do
        break if frame.full?

        shot = Shot.new(marks[index])
        frame.set(shot)
        index += 1
      end
    end

    sum_scores(@frames)
  end

  private

  def sum_scores(frames)
    frames.each_with_index.sum do |frame, index|
      sum = frame.score
      if frame.strike?
        sum += frames[index + 1].shots[0..1].sum(&:score)
        sum += frames[index + 2].shots[0].score if frames[index + 1].strike?
      elsif frame.spare?
        sum += frames[index + 1].shots[0].score
      end

      sum
    end
  end
end
