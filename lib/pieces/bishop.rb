require_relative "../helper_modules/pieces_modules/diagonal_positions"

# Has the moves and info for the bishop piece
class Bishop
  include DiagonalPositions

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  # Checks if the bishop can move to where the player wants it to move
  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_diagonal_moves(board, piece_cords, color)

    return true if legal_moves.include?(move_cords)

    false
  end
end
