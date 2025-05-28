require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains all the methods for the queen peice
class Queen
  include VerticalHorizontalAlgorithims
  include DiagonalAlgorithims

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_queen_moves(board, piece_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  def possible_queen_moves(board, piece_cords)
    possible_moves = []

    possible_bishop_moves(board, piece_cords).each { |cords| possible_moves << cords }
    possible_rook_moves(board, piece_cords).each { |cords| possible_moves << cords }

    possible_moves
  end
end
