# frozen_string_literal: true

class Frame
  attr_reader :shots, :first_shot, :second_shot
  attr_accessor :next_frame

  def initialize(*shots)
    @shots = []
    @first_shot = shots[0]
    @second_shot = shots[1]

    check_zero_after_strike
    check_score_over_ten
    raise 'Invalid frame (Strike is Only first shot)' if @first_shot.mark != 'X' && @second_shot.mark == 'X'

    @shots = @first_shot, @second_shot

    post_initialize(shots)
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    !last_frame? && @first_shot.mark == 'X'
  end

  def spare?
    return false if last_frame? || strike?

    @first_shot.score + @second_shot.score == 10
  end

  private

  def post_initialize(shots); end

  def last_frame?
    false
  end

  def check_zero_after_strike
    raise 'Invalid frame (No more shot after strike)' if @first_shot.mark == 'X' && @second_shot.mark != '0'
  end

  def check_score_over_ten
    raise 'Invalid frame (Over 10 scores)' if @first_shot.score + @second_shot.score > 10
  end
end
