# frozen_string_literal: true

class LastFrame < Frame
  def post_initialize
    @third_shot = nil
  end

  def frame(shot)
    return if full?

    @shots << if @first_shot.nil?
                @first_shot = shot
              elsif @second_shot.nil?
                validate_second_shot(shot)
                validate_total_two_score(shot)

                @second_shot = shot
              else

                @third_shot = shot
              end
  end

  def full?
    return false if @first_shot.nil? || @second_shot.nil?
    return false if @third_shot.nil? && max_score > 19

    true
  end

  def strike?
    false
  end

  def spare?
    false
  end

  def next_frame=(_)
    raise 'Last frame has no next frame'
  end

  def next_frame
    raise 'Last frame has no next frame'
  end

  def last_frame?
    true
  end

  private

  def max_score
    return 30 if @first_shot.mark == 'X' && @second_shot.mark == 'X'
    return 20 if @first_shot.mark == 'X' || @first_shot.score + @second_shot.score == MAX_SCORE

    MAX_SCORE
  end

  def validate_second_shot(shot)
    return if @first_shot.mark == 'X'

    raise 'Invalid shot (X can mark only after X)' if shot.mark == 'X'
  end

  def validate_total_two_score(shot)
    return if @first_shot.mark == 'X'

    super
  end
end
