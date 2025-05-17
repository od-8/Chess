require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/pawn"
require_relative "board_setup_module"

# Contains the board and all of its methods
class Board
  include BoardSetup
  attr_accessor :board

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    add_peices
  end

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

  def legal_position(row, column, color)
    true if board[row][column].nil? || board[row][column].color != color
  end

  def move(peice_cords, move_cords)
    peice = @board[peice_cords[0]][peice_cords[1]]

    @board = peice.move(@board, peice, peice_cords, move_cords)
  end

  def valid_move?(cords)
    return true if cords[0].between?(0, 7) && cords[1].between?(0, 7)

    false
  end

  def game_over?
    false
  end
end
