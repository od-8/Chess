require_relative "../pieces_modules/white_pawn_positions"
require_relative "../pieces_modules/black_pawn_positions"
require_relative "../pieces_modules/knight_positions"
require_relative "../pieces_modules/diagonal_positions"
require_relative "../pieces_modules/inline_positions"

# Checks if there is a pawn to the top left/top right of king, knight attacking it, or its inline with
# a bishop, rook or queen.
module Check
  include WhitePawnPositions
  include BlackPawnPositions
  include KnightPositions
  include DiagonalPositions
  include InlinePositions

  def in_check?(board, color, king_cords = nil)
    king_cords = find_king_coordinates(board, color) if king_cords.nil?
    king_is_in_check?(board, king_cords, color)
  end

  # Checks if the king is in check
  def king_is_in_check?(board, cords, color)
    return true if pawn_check?(board, cords, color) ||
                   knight_check?(board, cords, color) ||
                   diagonal_check?(board, cords, color) ||
                   inline_check?(board, cords, color)

    false
  end

  # Checks if there is a check from a pawn
  def pawn_check?(board, king_cords, color)
    pawn_check_positions = if color == "white"
                             white_take_positions(board, king_cords[0], king_cords[1])
                           else
                             black_take_positions(board, king_cords[0], king_cords[1])
                           end

    pawn_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "pawn" && color != piece.color
    end

    false
  end

  # Checks if there is a check from a knight
  def knight_check?(board, king_cords, color)
    knight_check_positions = possible_knight_moves(king_cords[0], king_cords[1])

    knight_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "knight" && color != piece.color
    end

    false
  end

  # Checks if there is a check from a bishop or from a queen
  def diagonal_check?(board, king_cords, color)
    diagonal_check_positions = possible_diagonal_moves(board, king_cords, color)

    diagonal_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[bishop queen].include?(piece&.name) && color != piece.color
    end

    false
  end

  # Checks if there is a check from a rook or a queen
  def inline_check?(board, king_cords, color)
    inline_check_positions = possible_inline_moves(board, king_cords, color)

    inline_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[rook queen].include?(piece&.name) && color != piece.color
    end

    false
  end
end
