# frozen_string_literal: true

class LastFrame < Frame
  def post_initialize(shots)
    return if shots.length < 3

    @third_shot = shots[2]
    @shots << @third_shot
  end

  def next_frame
    raise 'Last frame has no next frame'
  end

  private

  def last_frame?
    true
  end
end
