# frozen_string_literal: true

require_relative './lib/game'

marks = ARGV[0].split(',')

game = Game.new
puts game.play(marks)
