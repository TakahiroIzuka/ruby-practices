# frozen_string_literal: true

class Shot
  MAX_SCORE = 10

  attr_reader :mark

  def initialize(mark)
    validate_mark(mark)

    @mark = mark.to_s
  end

  def score
    @mark == 'X' ? MAX_SCORE : @mark.to_i
  end

  def self.shot_factory(marks)
    shots = []
    marks.each do |mark|
      shot = Shot.new(mark)
      shots << shot
      shots << Shot.new('0') if shot.mark == 'X' && shots.size < 18
    end

    shots
  end

  private

  def validate_mark(mark)
    raise 'Invalid mark' unless mark.to_s == 'X' || mark.to_i.between?(0, MAX_SCORE)
  end
end
