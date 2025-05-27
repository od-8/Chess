require_relative "../helper_methods/peices_helper_methods/knight_positions"
# Contains all the methods for the knight peices
class Knight
  include KnightPositions
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
  end

  def legal_move?(_board, peice_cords, move_cords)
    legal_moves = possible_positions(peice_cords[0], peice_cords[1])

    return true if legal_moves.include?(move_cords)

    false
  end
end
