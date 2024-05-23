# frozen_string_literal: true

class LastFrame < Frame
  def full?
    shots.size == 3 || shots.size == 2 && score < 10
  end

  def strike?
    false
  end

  def spare?
    false
  end
end
