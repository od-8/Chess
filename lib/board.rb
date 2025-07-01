# Helper methods
require_relative "helper_methods/board_helper_methods/board_setup_module"
require_relative "helper_methods/board_helper_methods/board_castling"
require_relative "helper_methods/board_helper_methods/promotion_methods"
require_relative "helper_methods/board_helper_methods/check_methods"
require_relative "helper_methods/board_helper_methods/checkmate_methods"
require_relative "helper_methods/peices_helper_methods/white_pawn_positions"
require_relative "helper_methods/peices_helper_methods/black_pawn_positions"
require_relative "helper_methods/peices_helper_methods/knight_positions"
require_relative "helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "helper_methods/peices_helper_methods/vertical_horizontal_algorithims"
require_relative "helper_methods/peices_helper_methods/king_positions"

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
  # include Castling
  include Promotion
  include Check
  include Checkmate
  include KingPositions
  include VerticalHorizontalAlgorithims
  include DiagonalAlgorithims
  include KnightPositions
  include WhitePawnMovement
  include BlackPawnMovement

  attr_accessor :board, :last_taken_piece, :white_king_moved, :black_king_moved

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @last_taken_piece = nil
    @white_king_moved = false
    @black_king_moved = false
    add_peices
  end

  # Prints the board so it is easy to understand and looks good
  def print_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts ""
    puts "+---+---+---+---+---+---+---+---+".center(54)
    board.reverse.each_with_index do |row, index|
      print " ".center(8)
      print "#{8 - index} |"
      row.each do |piece|
        print piece.nil? ? "   |" : " #{piece&.symbol} |"
      end
      puts ""
      puts "+---+---+---+---+---+---+---+---+".center(54)
    end
    puts "a   b   c   d   e   f   g   h".center(54)
    puts ""
  end

  # Moves the piece to where the player wants
  def move(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    piece = board[piece_cords[0]][piece_cords[1]]

    @last_taken_piece = board[move_cords[0]][move_cords[1]]
    @board[move_cords[0]][move_cords[1]] = piece
    @board[piece_cords[0]][piece_cords[1]] = nil
  end

  # Reverse's #move, its used to see reverse moves that are illegal
  def reverse_move(piece_cords, move_cords)
    piece = board[move_cords[0]][move_cords[1]]

    @board[move_cords[0]][move_cords[1]] = last_taken_piece
    @board[piece_cords[0]][piece_cords[1]] = piece
  end

  # Check if squre is occupied by same color peice
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end
end
