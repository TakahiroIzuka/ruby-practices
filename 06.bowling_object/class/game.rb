# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'
require_relative './shot'

class Game
  def initialize
    @frames = []
  end

  def play(marks)
    marks = add_zero_after_strike(marks)
    check_number_of_marks(marks)
    formatted_marks = formatted_marks(marks)

    formatted_marks.each_with_index do |marks_per_frame, index|
      shots = marks_per_frame.map { |mark| Shot.new(mark) }
      current_frame = index + 1

      frame = if current_frame < 10
                Frame.new(*shots)
              else
                LastFrame.new(*shots)
              end

      @frames.last.next_frame = frame unless @frames.empty?
      @frames << frame
    end
  end

  def score
    sum = 0
    return sum if @frames.empty?

    @frames.each do |frame|
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

  def add_zero_after_strike(marks)
    marks.each_with_index do |mark, index|
      next if index >= 18

      marks.insert(index + 1, '0') if mark.casecmp('X').zero?
    end
  end

  def check_number_of_marks(marks)
    raise 'Number of marks is invalid' unless marks.size == 20 || marks.size == 21
  end

  def formatted_marks(marks)
    formatted_marks = marks.each_slice(2).map { |array| array }
    if formatted_marks.size == 11
      formatted_marks[9].concat(formatted_marks[10])
      formatted_marks.delete_at(10)
    end

    formatted_marks
  end
end
