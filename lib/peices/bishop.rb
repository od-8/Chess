require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"

# Contains all the methods for the bishop peices
class Bishop
  include DiagonalAlgorithims

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_bishop_moves(board, piece_cords)

    return true if legal_moves.include?(move_cords)

    false
  end
end
