require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"

game = Game.new("jim", "bob")

game.play_game

game.board.print_board
