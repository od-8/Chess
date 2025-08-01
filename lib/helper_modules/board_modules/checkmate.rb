require_relative "../pieces_modules/white_pawn_positions"
require_relative "../pieces_modules/black_pawn_positions"
require_relative "../pieces_modules/knight_positions"
require_relative "../pieces_modules/diagonal_positions"
require_relative "../pieces_modules/inline_positions"
require_relative "../pieces_modules/queen_positions"
require_relative "../pieces_modules/king_positions"

# Gets all possible moves and is used to check if any can stop check, its also used for stalemate.
module Checkmate
  include WhitePawnPositions
  include BlackPawnPositions
  include KnightPositions
  include DiagonalPositions
  include InlinePositions
  include QueenPositions
  include KingPositions

  # Checks if the king is in checkmate
  def in_checkmate?(color)
    return true if stop_check_positions(color).empty?

    false
  end

  # Loops through board and calls #piece_handler on all the piece that are the same color as the king
  def stop_check_positions(color)
    valid_moves = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        next unless piece&.color == color

        piece_handler(piece, [row_index, piece_index], color).each { |move| valid_moves << move }
      end
    end

    valid_moves
  end

  # Determines which method to call by their name
  def piece_handler(piece, piece_cords, color) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    valid_moves = []

    case piece.name
    when "pawn"
      pawn_handler(piece, piece_cords, color).each { |move| valid_moves << move }
    when "knight"
      knight_moves = possible_knight_moves(piece_cords[0], piece_cords[1])
      move_places(piece_cords, knight_moves, color).each { |move| valid_moves << move }
    when "bishop"
      bishop_moves = possible_diagonal_moves(board, piece_cords, piece.color)
      move_places(piece_cords, bishop_moves, color).each { |move| valid_moves << move }
    when "rook"
      rook_moves = possible_inline_moves(board, piece_cords, piece.color)
      move_places(piece_cords, rook_moves, color).each { |move| valid_moves << move }
    when "queen"
      queen_moves = possible_queen_moves(board, piece_cords, piece.color)
      move_places(piece_cords, queen_moves, color).each { |move| valid_moves << move }
    when "king"
      possible_king_moves = possible_king_moves(piece_cords[0], piece_cords[1])
      move_places(piece_cords, possible_king_moves, color).each { |move| valid_moves << move }
    end

    valid_moves
  end

  # Handles the color issues with pawn
  def pawn_handler(piece, piece_cords, color)
    valid_moves = []

    if piece.color == "white"
      white_pawn_moves = white_pawn_positions(board, piece_cords)
      move_places(piece_cords, white_pawn_moves, color)
    end

    if piece.color == "black"
      black_pawn_moves = black_pawn_positions(board, piece_cords)
      move_places(piece_cords, black_pawn_moves, color)
    end

    valid_moves
  end

  # Gets all the moves that can block check
  def move_places(piece_cords, possible_moves, color)
    valid_moves = []

    possible_moves.each do |move_cords|
      next if move_cords.empty? || board[move_cords[0]][move_cords[1]]&.color == color

      clone_board = clone_and_update(piece_cords, move_cords)
      valid_moves << move_cords unless in_check?(clone_board, color)
    end

    valid_moves
  end
end
