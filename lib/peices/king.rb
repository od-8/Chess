require_relative "../helper_methods/peices_helper_methods/pawn_capturing"
require_relative "../helper_methods/peices_helper_methods/knight_positions"
require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains methods for king moving and check
class King
  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(_board, piece_cords, move_cords)
    legal_moves = possible_king_moves(piece_cords[0], piece_cords[1])

    return true if legal_moves.include?(move_cords)

    false
  end
end
