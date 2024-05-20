# frozen_string_literal: true

class Frame
  MAX_SCORE = 10

  attr_reader :shots, :next_frame

  def initialize(next_frame = nil)
    @next_frame = next_frame
    @shots = []
  end

  def set(shot)
    validate_second_shot(shot) if !shots[0].nil? && shots[1].nil?
    validate_total_score(shot)
    @shots << shot
  end

  def full?
    !shots[1].nil?
  end

  def score
    sum = @shots.sum(&:score)
    if strike?
      sum += next_frame.shots[0].score + next_frame.shots[1].score
      sum += next_frame.next_frame.shots[0].score if next_frame.strike?
    elsif spare?
      sum += next_frame.shots[0].score
    end

    sum
  end

  def strike?
    shots[0].mark == 'X'
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
    raise 'Invalid shot (Only 0 after X)' if shots[0].mark == 'X' && shot.mark != '0'
  end

  def validate_total_score(shot)
    raise "Invalid shot (Total score is at most #{max_score})" if @shots.sum(&:score) + shot.score > max_score
  end
end
