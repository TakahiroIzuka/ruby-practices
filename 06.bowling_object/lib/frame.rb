# frozen_string_literal: true

class Frame
  MAX_SCORE = 10

  attr_reader :shots
  attr_accessor :next_frame

  def initialize
    @shots = []
  end

  def set(shot)
    return if full?

    if !first_shot.nil? && second_shot.nil?
      validate_second_shot(shot)
      validate_total_two_score(shot)
    end

    @shots << shot
  end

  def first_shot
    shots[0]
  end

  def second_shot
    shots[1]
  end

  def full?
    !second_shot.nil?
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    first_shot.mark == 'X'
  end

  def spare?
    return false if strike? || !full?

    @shots[0..1].sum(&:score) == MAX_SCORE
  end

  def last_frame?
    false
  end

  private

  def validate_second_shot(shot)
    raise 'Invalid shot (X is only first shot)' if shot.mark == 'X'
    raise 'Invalid shot (Only 0 after X)' if first_shot.mark == 'X' && shot.mark != '0'
  end

  def validate_total_two_score(shot)
    total_score = first_shot.score + shot.score
    raise 'Invalid shot (Total score is at least 10 by the second shot unless first shot is X)' if total_score > MAX_SCORE
  end
end
