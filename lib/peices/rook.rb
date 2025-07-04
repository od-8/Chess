require_relative "../helper_methods/peices_helper_methods/inline_positions"

# Has the moves and info for the rook
class Rook
  include InlinePositions

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_rook_moves(board, piece_cords, color)

    return true if legal_moves.include?(move_cords)

    false
  end
end
