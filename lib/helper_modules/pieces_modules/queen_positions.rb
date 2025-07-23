require_relative "diagonal_positions"
require_relative "inline_positions"

# Gets all the moves for the queen
module QueenPositions
  include DiagonalPositions
  include InlinePositions

  # Gets all the possible moves for the queen
  def possible_queen_moves(board, piece_cords, color)
    possible_moves = possible_diagonal_moves(board, piece_cords, color).map { |cords| cords }
    possible_inline_moves(board, piece_cords, color).each { |cords| possible_moves << cords }

    possible_moves
  end
end
