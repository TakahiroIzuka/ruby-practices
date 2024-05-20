# frozen_string_literal: true

class Frame
  MAX_SCORE = 10

  attr_reader :shots, :next_frame

  def initialize(next_frame = nil)
    @next_frame = next_frame
    @shots = []
  end

  def set(shot)
    return if full?

    validate_second_shot(shot) if !first_shot.nil? && second_shot.nil?
    validate_total_score(shot)
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
    sum = @shots.sum(&:score)
    if strike?
      sum += next_frame.first_shot.score + next_frame.second_shot.score
      sum += next_frame.next_frame.first_shot.score if next_frame.strike?
    elsif spare?
      sum += next_frame.first_shot.score
    end

    sum
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

  def max_score
    MAX_SCORE
  end

  def validate_second_shot(shot)
    raise 'Invalid shot (X is only first shot)' if shot.mark == 'X'
    raise 'Invalid shot (Only 0 after X)' if first_shot.mark == 'X' && shot.mark != '0'
  end

  def validate_total_score(shot)
    raise "Invalid shot (Total score is at most #{max_score})" if @shots.sum(&:score) + shot.score > max_score
  end
end
