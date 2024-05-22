# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize
    @shots = []
  end

  def set(shot)
    @shots << shot
    @shots << Shot.new('0') if strike?
  end

  def full?
    !shots[1].nil?
  end

  def score
    shots.sum(&:score)
  end

  def strike?
    shots[0].mark == 'X'
  end

  def spare?
    return false if strike?

    @shots[0..1].sum(&:score) == max_score
  end

  private

  def max_score
    10
  end
end
