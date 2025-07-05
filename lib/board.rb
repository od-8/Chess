# Helper stuff
require_relative "helper_methods/board_helper_methods/add_pieces_to_board"
require_relative "helper_methods/board_helper_methods/castling"
require_relative "helper_methods/board_helper_methods/promotion"
require_relative "helper_methods/board_helper_methods/check"
require_relative "helper_methods/board_helper_methods/checkmate"

# Movement for all the pieces
require_relative "helper_methods/peices_helper_methods/white_pawn_positions"
require_relative "helper_methods/peices_helper_methods/black_pawn_positions"
require_relative "helper_methods/peices_helper_methods/knight_positions"
require_relative "helper_methods/peices_helper_methods/diagonal_positions"
require_relative "helper_methods/peices_helper_methods/inline_positions"
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
  include AddPieces
  include Castling
  include Promotion
  include Check
  include Checkmate
  include KingPositions
  include InlinePositions
  include DiagonalPositions
  include KnightPositions
  include WhitePawnPositions
  include BlackPawnPositions

  attr_accessor :board, :white_king_moved, :black_king_moved

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @white_king_moved = false
    @black_king_moved = false
    add_peices
  end

  # Prints the board so it looks like a chess board
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

  # Moves piece from where it currently is (piece_cords) to where it wants to go (move_cords)
  def move(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    piece = board[piece_cords[0]][piece_cords[1]]
    piece = promotion(piece, move_cords) if piece.name == "pawn"
    castling(piece_cords, move_cords) if piece.name == "king"

    @board[move_cords[0]][move_cords[1]] = piece
    @board[piece_cords[0]][piece_cords[1]] = nil
  end

  # Checks if the square is occupied by a piece with the same color
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end

  # Deep copys the board then makes the move
  # Used to check future state of board and if a move is valid, like you cant make a move that puts you in check
  def clone_and_update(piece_cords, move_cords)
    clone_board = Marshal.load(Marshal.dump(board))
    piece = clone_board[piece_cords[0]][piece_cords[1]]

    clone_board[move_cords[0]][move_cords[1]] = piece

    clone_board[piece_cords[0]][piece_cords[1]] = nil

    clone_board
  end
end

# Notes:
# 1 - Could try and adjust clone and update so instead it clones then calls move for more DRY code
