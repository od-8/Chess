require_relative "../helper_methods/peices_helper_methods/king_positions"

# Has the moves and info for the king
class King
  include Check
  include KingPositions
  attr_accessor :name, :symbol, :color, :king_moved

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
    @king_moved = false
  end

  # Checks if the king can move to where the player wants it to move
  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_king_moves(piece_cords[0], piece_cords[1])
    castling(board, piece_cords[0], piece_cords[1]).each { |move| legal_moves << move }

    return true if legal_moves.include?(move_cords)

    false
  end

  # Allows king to castle if its legal
  def castling(board, x, y) # rubocop:disable Naming/MethodParameterName
    possible_moves = []
    possible_moves << [x, y + 2] if king_side_is_legal?(board, x, y)
    possible_moves << [x, y - 2] if queen_side_is_legal?(board, x, y)
    possible_moves
  end

  # Checks if king isde castling is legal
  def king_side_is_legal?(board, x, y) # rubocop:disable Naming/MethodParameterName
    return true if king_moved == false &&
                   board[x][y + 1].nil? && in_check?(board, [x, y + 1], color) == false &&
                   board[x][y + 2].nil? && in_check?(board, [x, y + 2], color) == false

    false
  end

  # Checks if queen side castling is legal
  def queen_side_is_legal?(board, x, y) # rubocop:disable Naming/MethodParameterName
    return true if king_moved == false &&
                   board[x][y - 1].nil? && in_check?(board, [x, y - 1], color) == false &&
                   board[x][y - 2].nil? && in_check?(board, [x, y - 2], color) == false

    false
  end
end
