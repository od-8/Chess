require_relative "../helper_modules/pieces_modules/queen_positions"

# Has the moves and info for the queen
class Queen
  include QueenPositions

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  # Checks if the queen can move to where the player wants it to move
  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_queen_moves(board, piece_cords, color)

    return true if legal_moves.include?(move_cords)

    false
  end
end
