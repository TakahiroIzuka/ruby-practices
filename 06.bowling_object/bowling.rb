# frozen_string_literal: true

require_relative './lib/game'

mark = ARGV[0]
marks = mark.split(',')

game = Game.new
game.play(marks)

puts game.score
