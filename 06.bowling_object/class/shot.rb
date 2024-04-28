# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    raise 'Invalid mark' unless mark.to_s.casecmp('X').zero? || mark.to_i.between?(0, 10)

    @mark = mark.to_s.upcase
  end

  def score
    return 10 if @mark == 'X'

    @mark.to_i
  end
end
