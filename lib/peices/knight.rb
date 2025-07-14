require_relative "../helper_methods/peices_helper_methods/knight_positions"

# Has the moves and info for the knight
class Knight
  include KnightPositions
  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  # Checks if the knight can move to where the player wants it to move
  def legal_move?(_board, piece_cords, move_cords)
    legal_moves = possible_knight_moves(piece_cords[0], piece_cords[1])

    return true if legal_moves.include?(move_cords)

    false
  end
end
