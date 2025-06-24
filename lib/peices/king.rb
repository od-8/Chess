require_relative "../helper_methods/peices_helper_methods/king_positions"
require_relative "../board"

# Contains methods for king moving and check
class King
  include KingPositions
  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_king_moves(piece_cords[0], piece_cords[1])
    castling(board, piece_cords[0], piece_cords[1]).each { |move| legal_moves << move}

    return true if legal_moves.include?(move_cords)

    false
  end

  def castling(board, x, y)
    possible_moves = []
    possible_moves << [x, y + 2] if castling_is_legal?(board, [x, y + 2], color)
    possible_moves << [x, y - 2] if castling_is_legal?(board, [x, y - 2], color)
  end

  def castling_is_legal?(board, cords, color)
    
  end
end
