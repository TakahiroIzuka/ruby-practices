# frozen_string_literal: true

# LastFrameクラスを定義
class LastFrame < Frame
  def post_initialize(shots)
    @shots << shots[2] if shots.length == 3
  end
end
