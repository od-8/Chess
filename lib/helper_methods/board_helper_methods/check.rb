require_relative "../peices_helper_methods/white_pawn_positions"
require_relative "../peices_helper_methods/black_pawn_positions"
require_relative "../peices_helper_methods/knight_positions"
require_relative "../peices_helper_methods/diagonal_positions"
require_relative "../peices_helper_methods/inline_positions"

# Checks if there is a pawn to the top left/top right of king, knight attacking it, or its inline with
# a bishop, rook or queen.
module Check
  include WhitePawnPositions
  include BlackPawnPositions
  include KnightPositions
  include DiagonalPositions
  include InlinePositions

  # Checks if the king is in check
  def in_check?(board, cords, color)
    return true if pawn_check?(board, cords, color) ||
                   knight_check?(board, cords, color) ||
                   diagonal_check?(board, cords, color) ||
                   inline_check?(board, cords, color)

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

  # Checks if there is a check from a knight
  def knight_check?(board, piece_cords, color)
    knight_check_positions = possible_knight_moves(piece_cords[0], piece_cords[1])

    knight_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "knight" && color != piece.color
    end

    false
  end

  # Checks if there is a check from a bishop or from a queen
  def diagonal_check?(board, king_cords, color)
    diagonal_check_positions = possible_bishop_moves(board, king_cords, color)

    diagonal_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[bishop queen].include?(piece&.name) && color != piece.color
    end

    false
  end

  # Checks if there is a check from a rook or a queen
  def inline_check?(board, king_cords, color)
    inline_check_positions = possible_rook_moves(board, king_cords, color)

    inline_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if %w[rook queen].include?(piece&.name) && color != piece.color
    end

    false
  end
end
