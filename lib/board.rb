require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/pawn"
require_relative "helper_modules"

# Contains the board and all of its methods
class Board
  include BoardSetup
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
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

  def move(row, column)
    peice = board[column][row]
    p column
    p row

    @board = peice.move(row, column, peice, @board)
  end
end
