# frozen_string_literal: true

require_relative './class/game'

mark = ARGV[0]
marks = mark.split(',')

game = Game.new
game.play(marks)
score = game.score

puts score
