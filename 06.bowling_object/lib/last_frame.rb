# frozen_string_literal: true

class LastFrame < Frame
  def third_shot
    @shots[2]
  end

  def full?
    return false if first_shot.nil? || second_shot.nil?
    return false if third_shot.nil? && max_score > 19

    true
  end

  def strike?
    false
  end

  def spare?
    false
  end

  def last_frame?
    true
  end

  private

  def max_score
    return 30 if @shots.size >= 2 && first_shot.mark == 'X' && second_shot.mark == 'X'
    return 20 if @shots.size >= 1 && first_shot.mark == 'X' || @shots[0..1].sum(&:score) == MAX_SCORE

    MAX_SCORE
  end

  def validate_second_shot(shot)
    raise 'Invalid shot (X can mark only after X)' if first_shot.mark != 'X' && shot.mark == 'X'
  end
end
