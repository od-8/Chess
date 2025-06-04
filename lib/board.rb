# Helper methods
require_relative "helper_methods/board_helper_methods/board_setup_module"
require_relative "helper_methods/peices_helper_methods/pawn_capturing"
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
class Board # rubocop:disable Metrics/ClassLength
  include BoardSetup
  include KingPositions
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

  def same_color?(piece_cords, player_color)
    return true if board[piece_cords[0]][piece_cords[1]]&.color == player_color

    false
  end

  # Calls the move method on whichever peice is selected
  def move(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    piece = board[piece_cords[0]][piece_cords[1]] # Gets the peice the player would like to move

    # Checks if the peice can move there and it isnt occupied by a friendly, if so it moves there
    if piece.legal_move?(board, piece_cords, move_cords) && unnocupied_square?(piece, move_cords)

      # Updates the position of the king if its being moved
      update_king_position(piece, move_cords) if piece.name == "king"

      @board[move_cords[0]][move_cords[1]] = piece
      @board[piece_cords[0]][piece_cords[1]] = nil

    else
      puts "Invalid move"
    end

    check_and_checkmate
  end

  # Check if squre is occupied by same color peice
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end

  # Updates king cords when king is moved
  def update_king_position(piece, move_cords)
    self.white_king_cords = move_cords if piece.color == "white"

    self.black_king_cords = move_cords if piece.color == "black"
  end

  def check_and_checkmate
    if in_check?(white_king_cords, "white")
      puts "Check"
      puts "Checkmate" if checkmate?(white_king_cords, "white")
    end

    if in_check?(black_king_cords, "black") # rubocop:disable Style/GuardClause
      puts "Check"
      puts "Checkmate" if checkmate?(black_king_cords, "black")
    end
  end

  def in_check?(cords, color)
    if pawn_check?(board, cords, color) || knight_check?(board, cords, color) || diagonal_check?(board, cords, color) || inline_check?(board, cords, color) # rubocop:disable Layout/LineLength
      true
    end
  end

  def checkmate?(king_cords, color)
    king_moves = possible_king_moves(king_cords[0], king_cords[1])

    king_moves.all? { |move| board[move[0]][move[1]]&.color == color || in_check?(move, color) == true }
  end

  # Checks if their is a check from a pawn
  def pawn_check?(board, piece_cords, color)
    pawn_check_positions = if color == "white"
                             white_take_positions(board, piece_cords[0], piece_cords[1])
                           else
                             black_take_positions(board, piece_cords[0], piece_cords[1])
                           end

    pawn_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "pawn" && color != piece.color
    end

    false
  end

  # Checks if king is in check from a kngiht
  def knight_check?(board, piece_cords, color)
    knight_check_positions = possible_knight_moves(piece_cords[0], piece_cords[1])

    # Takes the current position of the king and check if there are any knight checking it
    knight_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "knight" && color != piece.color
    end

    false
  end

  # Checks if king is in check from a bishop or diagonal by queen
  def diagonal_check?(board, king_cords, color)
    diagonal_check_positions = possible_bishop_moves(board, king_cords, color)

    diagonal_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[bishop queen].include?(piece&.name) && color != piece.color
    end

    false
  end

  # Checks if king is in check from rook or inline by queen
  def inline_check?(board, king_cords, color)
    inline_check_positions = possible_rook_moves(board, king_cords, color)

    inline_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[rook queen].include?(piece&.name) && color != piece.color
    end

    false
  end
end
