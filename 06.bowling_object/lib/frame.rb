# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize
    @shots = []
  end

  def set(shot)
    validate_second_shot(shot) if !shots[0].nil? && shots[1].nil?
    validate_total_score(shot)
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

  def validate_second_shot(shot)
    raise 'Invalid shot (X is only first shot)' if shot.mark == 'X'
  end

  def validate_total_score(shot)
    raise "Invalid shot (Total score is at most #{max_score})" if @shots.sum(&:score) + shot.score > max_score
  end
end
