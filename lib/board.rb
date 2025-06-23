# Helper methods
require_relative "helper_methods/board_helper_methods/board_setup_module"
require_relative "helper_methods/board_helper_methods/castling_methods"
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
class Board # rubocop:disable Metrics/ClassLength
  include BoardSetup
  include KingPositions
  include VerticalHorizontalAlgorithims
  include DiagonalAlgorithims
  include KnightPositions
  include PawnCapturing

  attr_accessor :board, :last_taken_piece, :white_king_moved, :black_king_moved

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @last_taken_piece = nil
    @white_king_moved = false
    @black_king_move = false
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
  def move(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    piece = board[piece_cords[0]][piece_cords[1]]

    @white_king_moved = true if piece == "king" && piece.color == "white"
    @black_king_move = true if piece == "king" && piece.color == "black"
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
  def checkmate?(king_cords, color)
    return true if stop_check_positions(king_cords, color).empty?

    false
  end

  # Loops through board and adds call #piece_handler on all the piece that are the same color as the king passed
  def stop_check_positions(king_cords, color)
    valid_moves = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        next unless piece&.color == color

        piece_handler(piece, [row_index, piece_index], king_cords, color).each { |move| valid_moves << move }
      end
    end

    valid_moves
  end

  # Determines which method to call by their name
  def piece_handler(piece, piece_cords, king_cords, color) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    valid_moves = []

    case piece.name
    when "pawn"
      pawn_handler(piece, piece_cords, king_cords, color).each { |move| valid_moves << move }
    when "knight"
      move_places(piece_cords, possible_knight_moves(piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    when "bishop"
      move_places(piece_cords, possible_bishop_moves(board, piece_cords, piece.color), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    when "rook"
      move_places(piece_cords, possible_rook_moves(board, piece_cords, piece.color), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    when "queen"
      move_places(piece_cords, possible_bishop_moves(board, piece_cords, piece.color), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
      move_places(piece_cords, possible_rook_moves(board, piece_cords, piece.color), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    when "king"
      king_handler(king_cords, color).each { |move| valid_moves << move }
    end

    valid_moves
  end

  # Handles the color issues with pawn
  def pawn_handler(piece, piece_cords, king_cords, color) # rubocop:disable Metrics/AbcSize
    valid_moves = []

    if piece.color == "white"
      move_places(piece_cords, white_move_one_forward(piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
      move_places(piece_cords, white_move_two_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    end

    if piece.color == "black"
      move_places(piece_cords, black_move_one_forward(piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
      move_places(piece_cords, black_move_two_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    end

    valid_moves
  end

  # Handles when the piece is a king and can only move to non check/empty spots
  def king_handler(king_cords, color)
    valid_moves = []

    possible_king_moves(king_cords[0], king_cords[1]).each do |move_cords|
      next if board[move_cords[0]][move_cords[1]]&.color == color

      move(king_cords, move_cords)

      valid_moves << move_cords if in_check?(move_cords, color) == false

      reverse_move(king_cords, move_cords)
    end

    valid_moves
  end

  # Gets all the moves that can block check
  def move_places(piece_cords, possible_moves, king_cords, color)
    valid_moves = []

    possible_moves.each do |move_cords|
      next if move_cords.empty?

      move(piece_cords, move_cords)
      valid_moves << move_cords unless in_check?(king_cords, color)
      reverse_move(piece_cords, move_cords)
    end

    valid_moves
  end

  def castling_is_legal(castle_side, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize
    return true if castle_side == "king side" && color == "white" && legal_castling?([0, 5], [0, 6], [0, 7], "white")
    return true if castle_side == "queen side" && color == "white" && legal_castling?([0, 3], [0, 2], [0, 0], "white")

    return true if castle_side == "king side" && color == "black" && legal_castling?([7, 5], [7, 6], [7, 7], "black")
    return true if castle_side == "queen side" && color == "black" && legal_castling?([7, 3], [7, 2], [7, 0], "black")

    false
  end

  def legal_castling?(one, two, rook, color) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity
    return true if white_king_moved == false &&
                   board[one[0]][one[1]].nil? && in_check?(one, color) == false &&
                   board[two[0]][two[1]].nil? && in_check?(two, color) == false &&
                   board[rook[0]][rook[1]].name == "rook" && board[rook[0]][rook[1]].color == color

    false
  end

  def castling_move(castle_side, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    move_castle_pieces([0, 4], [0, 7], [0, 6], [0, 5]) if castle_side == "king side" && color == "white"
    move_castle_pieces([0, 4], [0, 0], [0, 6], [0, 5]) if castle_side == "queen side" && color == "white"

    move_castle_pieces([7, 4], [7, 7], [7, 6], [7, 5]) if castle_side == "king side" && color == "black"
    move_castle_pieces([7, 4], [7, 0], [7, 6], [7, 5]) if castle_side == "queen side" && color == "black"
  end

  def move_castle_pieces(king, rook, king_move, rook_move) # rubocop:disable Metrics/AbcSize
    king_piece = board[king[0]][king[1]]
    rook_piece = board[rook[0]][rook[1]]

    @board[king_move[0]][king_move[1]] = king_piece
    @board[rook_move[0]][rook_move[1]] = rook_piece
    @board[king[0]][king[1]] = nil
    @board[rook[0]][rook[1]] = nil
  end
end
