# frozen_string_literal: true

class Shot
  MAX_SCORE = 10

  attr_reader :mark

  def initialize(mark)
    validate_mark(mark)

    @mark = mark
  end

  def score
    @mark == 'X' ? MAX_SCORE : @mark.to_i
  end

  def strike?
    @mark == 'X'
  end

  private

  def validate_mark(mark)
    raise 'Invalid mark' unless mark.to_s == 'X' || mark.to_i.between?(0, MAX_SCORE)
  end
end
