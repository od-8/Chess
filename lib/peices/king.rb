require_relative "../helper_methods/peices_helper_methods/king_positions"

# Has the moves and info for the king
class King
  include KingPositions
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

  def castling(x, y) # rubocop:disable Naming/MethodParameterName
    possible_moves = []
    possible_moves << [x, y + 2] if board.castling_is_legal?([x, y + 2], color)
    possible_moves << [x, y - 2] if board.castling_is_legal?([x, y - 2], color)
  end
end
