# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize
    @shots = []
  end

  def set(shot)
    @shots << shot
  end

  def full?
    strike? || shots.size == 2
  end

  def strike?
    shots.size == 1 && shots[0].strike?
  end

  def spare?
    !strike? && score == 10
  end

  def score
    shots.sum(&:score)
  end
end
