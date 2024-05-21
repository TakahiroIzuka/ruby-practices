# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    validate_mark(mark)

    @mark = mark
  end

  def score
    @mark == 'X' ? 10 : @mark.to_i
  end

  def strike?
    @mark == 'X'
  end

  private

  def validate_mark(mark)
    raise 'Invalid mark' unless mark.to_s == 'X' || mark.to_i.between?(0, 10)
  end
end
