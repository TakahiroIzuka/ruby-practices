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

  def score
    @shots.reduce(0) do |sum, shot|
      if shot.mark == 'X'
        sum + 10
      else
        sum + shot.mark.to_i
      end
    end
  end

  private

  def post_initialize(shots); end
end
