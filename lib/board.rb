# Helper methods
require_relative "helper_methods/board_helper_methods/board_setup_module"
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

  # Moves the piece to where the player wants
  def move(piece_cords, move_cords)
    piece = board[piece_cords[0]][piece_cords[1]]

    @board[move_cords[0]][move_cords[1]] = piece
    @board[piece_cords[0]][piece_cords[1]] = nil
  end

  # Reverse's #move, is used if player makes an illegal move
  def reverse_move(piece_cords, move_cords)
    piece = board[move_cords[0]][move_cords[1]]

    @board[move_cords[0]][move_cords[1]] = nil
    @board[piece_cords[0]][piece_cords[1]] = piece
  end

  # Check if squre is occupied by same color peice
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end

  # Checks if king is in check
  def in_check?(cords, color)
    if pawn_check?(board, cords, color) || knight_check?(board, cords, color) || diagonal_check?(board, cords, color) || inline_check?(board, cords, color) # rubocop:disable Layout/LineLength
      return true
    end

    false
  end

  # Checks if there is a check from a pawn
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

  # Checks if there is a check from a kngiht
  def knight_check?(board, piece_cords, color)
    knight_check_positions = possible_knight_moves(piece_cords[0], piece_cords[1])

    knight_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "knight" && color != piece.color
    end

    false
  end

  # Checks if there is a check from a bishop or from queen
  def diagonal_check?(board, king_cords, color)
    diagonal_check_positions = possible_bishop_moves(board, king_cords, color)

    diagonal_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[bishop queen].include?(piece&.name) && color != piece.color
    end

    false
  end

  # Checks if there is a check from a rook or queen
  def inline_check?(board, king_cords, color)
    inline_check_positions = possible_rook_moves(board, king_cords, color)

    inline_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[rook queen].include?(piece&.name) && color != piece.color
    end

    false
  end

  # Checks if king is in checkmate
  def checkmate?(king_cords, color) # rubocop:disable Metrics/MethodLength,Metrics/CyclomaticComplexity
    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        next unless piece&.color == color

        piece_cords = [row_index, piece_index]
        puts piece.name
        case piece.name
        when "pawn"
          # do something
        when "knight"
          move_places(piece_cords, possible_knight_moves(piece_cords[0], piece_cords[1]), king_cords, color)
        when "bishop"
          move_places(piece_cords, possible_bishop_moves(board, piece_cords, piece.color), king_cords, color)
        when "rook"
          move_places(piece_cords, possible_rook_moves(board, piece_cords, piece.color), king_cords, color)
        end
      end
    end
  end

  def move_places(piece_cords, possible_moves, king_cords, color)
    valid_moves = []

    possible_moves.each do |move_cords|
      break if move_cords.empty?

      move(piece_cords, move_cords)
      valid_moves << move_cords unless in_check?(king_cords, color)
      reverse_move(piece_cords, move_cords)
    end

    p valid_moves
    puts ""
  end
end

# loop throught the bood
# add all black pieces to an array
# loop throught the array
# loop through each one of the pieces
# check if any of them can stop check
# return the moves that stop check for that piece
# do that for all pieces
# if no moves returned then its checkmate
########################################################
# check if the king has no moves, if true then go to next step, if false not checkmate
