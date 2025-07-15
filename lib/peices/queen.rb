require_relative "../helper_methods/peices_helper_methods/diagonal_positions"
require_relative "../helper_methods/peices_helper_methods/inline_positions"

# Has the moves and info for the queen
class Queen
  include InlinePositions
  include DiagonalPositions

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  # Checks if the queen can move to where the player wants it to move
  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_queen_moves(board, piece_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  # Gets all the possible moves for the queen
  def possible_queen_moves(board, piece_cords)
    possible_moves = possible_bishop_moves(board, piece_cords, color).map { |cords| cords }
    possible_rook_moves(board, piece_cords, color).each { |cords| possible_moves << cords }

    possible_moves
  end
end
