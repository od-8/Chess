require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/pawn"
require_relative "helper_methods/board_helper_methods/board_setup_module"

# Contains the board and all of its methods
class Board
  include BoardSetup
  attr_accessor :board

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    add_peices
  end

  # Prints the board so it is easy to understand and looks good
  def print_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts ""
    puts "  +---+---+---+---+---+---+---+---+"
    board.reverse.each_with_index do |row, index|
      print "#{8 - index} |"
      row.each do |peice|
        print " #{peice.peice} |" unless peice.nil?
        print "   |" if peice.nil?
      end
      puts ""
      puts "  +---+---+---+---+---+---+---+---+"
    end
    puts "    a   b   c   d   e   f   g   h"
    puts ""
  end

  # Calls the move method on whichever peice is selected
  def move(peice_cords, move_cords)
    peice = @board[peice_cords[0]][peice_cords[1]]

    @board = peice.move(@board, peice, peice_cords, move_cords)
  end

  # Makes sure the coordinates are valid
  def valid_move?(cords)
    letter = cords[0]
    number = cords[1].to_i - 1
    return true if letter.between?("a", "h") && number.between?(0, 7)

    false
  end

  # Checks if it is checkmate
  def checkmate?
    false
  end
end
