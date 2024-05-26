# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(index)
    @index = index
    @shots = []
  end

  def set(shot)
    @shots << shot
  end

  def full?
    strike? || shots.size == 2
  end

  def strike?
    shots[0]&.strike?
  end

  def spare?
    !strike? && shots.sum(&:score) == 10
  end

  def calc_score(frames)
    sum = shots.sum(&:score)
    if strike?
      sum += frames[@index + 1].shots[0..1].sum(&:score)
      sum += frames[@index + 2].shots[0].score if frames[@index + 1].strike?
    elsif spare?
      sum += frames[@index + 1].shots[0].score
    end

    sum
  end
end
