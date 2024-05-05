# frozen_string_literal: true

class Frame
  MAX_SCORE = 10

  attr_reader :shots, :first_shot, :second_shot
  attr_accessor :next_frame

  def initialize
    @first_shot = nil
    @second_shot = nil
    @shots = []

    post_initialize
  end

  def frame(shot)
    return if full?

    @shots << if @first_shot.nil?
                @first_shot = shot
              elsif @second_shot.nil?
                validate_second_shot(shot)
                validate_total_two_score(shot)

                @second_shot = shot
              end
  end

  def full?
    !@second_shot.nil?
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    !last_frame? && @first_shot.mark == 'X'
  end

  def spare?
    return false if last_frame? || strike?

    @first_shot.score + @second_shot.score == MAX_SCORE
  end

  def last_frame?
    false
  end

  private

  def post_initialize; end

  def validate_total_two_score(shot)
    total_score = @first_shot.score + shot.score
    raise 'Invalid shot (Total score is at least 10 by the second shot unless first shot is X)' if total_score > MAX_SCORE
  end

  def validate_second_shot(shot)
    raise 'Invalid shot (X is only first shot)' if shot.mark == 'X'
    raise 'Invalid shot (Only 0 after X)' if @first_shot.mark == 'X' && shot.mark != '0'
  end
end
