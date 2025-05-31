# Peice move functionality
require_relative "helper_methods/board_helper_methods/board_setup_module"
require_relative "helper_methods/peices_helper_methods/vertical_horizontal_algorithims"
require_relative "helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "helper_methods/peices_helper_methods/knight_positions"
require_relative "helper_methods/peices_helper_methods/pawn_capturing"

# Peices
require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/white_pawn"
require_relative "peices/black_pawn"

# Contains the board and all of its methods
class Board
  include BoardSetup

  include VerticalHorizontalAlgorithims
  include DiagonalAlgorithims
  include KnightPositions
  include PawnCapturing

  attr_accessor :board, :white_king_cords, :black_king_cords

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @white_king_cords = [0, 3]
    @black_king_cords = [7, 3]
    add_peices
  end

  # Prints the board so it is easy to understand and looks good
  def print_board # rubocop:disable Metrics/MethodLength
    puts ""
    puts "  +---+---+---+---+---+---+---+---+"
    board.reverse.each_with_index do |row, index|
      print "#{8 - index} |"
      row.each do |piece|
        print piece.nil? ? "   |" : " #{piece&.symbol} |"
      end
      puts ""
      puts "  +---+---+---+---+---+---+---+---+"
    end
    puts "    a   b   c   d   e   f   g   h"
    puts ""
  end

  # Calls the move method on whichever peice is selected
  def move(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    piece = board[piece_cords[0]][piece_cords[1]] # Gets the peice the player would like to move

    in_check(white_king_cords)
    in_check(black_king_cords)

    # Checks if the peice can move there and it isnt occupied by a friendly, if so it moves there
    if piece.legal_move?(board, piece_cords, move_cords) && unnocupied_square?(piece, move_cords)

      # Updates the position of the king if its being moved
      update_king_position(piece, move_cords) if piece.name == "king"

      @board[move_cords[0]][move_cords[1]] = piece
      @board[piece_cords[0]][piece_cords[1]] = nil

    else
      puts "Invalid move"
    end
  end

  # Check if squre is occupied by same color peice
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end

  # Checks if it is checkmate
  def checkmate?
    false
  end

  # Updates king cords when king is moved
  def update_king_position(piece, move_cords)
    self.white_king_cords = move_cords if piece.color == "white"

    self.black_king_cords = move_cords if piece.color == "black"
  end

  def in_check(cords)
    board[cords[0]][cords[1]].in_check?(board, cords)
  end

  # To do
  # - Check from bishop
  # - Check from Rook
  # - Check from Pawn
end
