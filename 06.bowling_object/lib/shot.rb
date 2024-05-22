# frozen_string_literal: true

class Shot
  MAX_SCORE = 10

  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    @mark == 'X' ? MAX_SCORE : @mark.to_i
  end

  def strike?
    @mark == 'X'
  end
end
