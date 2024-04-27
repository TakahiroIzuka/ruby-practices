# frozen_string_literal: true

# Shotクラスを定義
class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end
