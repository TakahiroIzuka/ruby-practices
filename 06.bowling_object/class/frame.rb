# frozen_string_literal: true

# Frameクラスを定義
class Frame
  attr_reader :shots

  def initialize(*shots)
    @shots = []
    @shots << shots[0]
    @shots << shots[1]

    post_initialize(shots)
  end

  private

  def post_initialize(shots); end
end
