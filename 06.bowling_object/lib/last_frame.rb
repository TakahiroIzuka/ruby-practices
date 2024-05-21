# frozen_string_literal: true

class LastFrame < Frame
  def full?
    return true if shots.size == 3
    return false if shots[0].nil? || shots[1].nil? || shots[0..1].sum(&:score) >= 10

    true
  end

  def strike?
    false
  end

  def spare?
    false
  end

  private

  def max_score
    return 30 if @shots.size >= 2 && shots[0].mark == 'X' && shots[1].mark == 'X'
    return 20 if @shots.size >= 1 && shots[0].mark == 'X' || @shots[0..1].sum(&:score) == 10

    10
  end

  def validate_second_shot(shot)
    raise 'Invalid shot (X can mark only after X)' if shots[0].mark != 'X' && shot.mark == 'X'
  end
end
