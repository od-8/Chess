require_relative "../pieces_modules/white_pawn_positions"
require_relative "../pieces_modules/black_pawn_positions"
require_relative "../pieces_modules/knight_positions"
require_relative "../pieces_modules/diagonal_positions"
require_relative "../pieces_modules/inline_positions"
require_relative "../pieces_modules/king_positions"

# Gets all possible moves and is used to check if any can stop check, its also used for stalemate.
module Checkmate
  include WhitePawnPositions
  include BlackPawnPositions
  include KnightPositions
  include DiagonalPositions
  include InlinePositions
  include KingPositions

  # Checks if the king is in checkmate
  def checkmate?(king_cords, color)
    return true if stop_check_positions(king_cords, color).empty?

    false
  end

  # Loops through board and calls #piece_handler on all the piece that are the same color as the king
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
      move_places(piece_cords, white_move_one_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
      move_places(piece_cords, white_move_two_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    end

    if piece.color == "black"
      move_places(piece_cords, black_move_one_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
      move_places(piece_cords, black_move_two_forward(board, piece_cords[0], piece_cords[1]), king_cords, color).each { |move| valid_moves << move } # rubocop:disable Layout/LineLength
    end

    valid_moves
  end

  # Handles when the piece is a king and can only move to non check or empty squares
  def king_handler(king_cords, color)
    valid_moves = []

    possible_king_moves(king_cords[0], king_cords[1]).each do |move_cords|
      next if board[move_cords[0]][move_cords[1]]&.color == color

      clone_board = clone_and_update(king_cords, move_cords)

      valid_moves << move_cords unless in_check?(clone_board, move_cords, color)
    end

    valid_moves
  end

  # Gets all the moves that can block check
  def move_places(piece_cords, possible_moves, king_cords, color)
    valid_moves = []

    possible_moves.each do |move_cords|
      next if move_cords.empty?

      clone_board = clone_and_update(piece_cords, move_cords)
      valid_moves << move_cords unless in_check?(clone_board, king_cords, color)
    end

    valid_moves
  end
end
