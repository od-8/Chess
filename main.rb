require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"

game = Game.new("jim", "bob")

game.board.print_board
