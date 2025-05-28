require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains all the methods for the rook peices
class Rook
  include VerticalHorizontalAlgorithims

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_rook_moves(board, piece_cords)

    return true if legal_moves.include?(move_cords)

    false
  end
end
