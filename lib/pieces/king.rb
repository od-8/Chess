require_relative "../helper_modules/pieces_modules/king_positions"
require_relative "../helper_modules/board_modules/check"

# Has the moves and info for the king
class King
  include Check
  include KingPositions
  attr_accessor :name, :symbol, :color, :has_moved

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
    @has_moved = false
  end

  # Checks if the king can move to where the player wants it to move
  def legal_move?(board, piece_cords, move_cords)
    legal_moves = possible_king_moves(piece_cords[0], piece_cords[1])
    # castling(board, piece_cords[0], piece_cords[1]).each { |move| legal_moves << move }

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
  def king_side_is_legal?(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    return true if has_moved == false && in_check?(board, [x, y], color) == false &&
                   board[x][y + 1].nil? && in_check?(board, [x, y + 1], color) == false &&
                   board[x][y + 2].nil? && in_check?(board, [x, y + 2], color) == false &&
                   board[x][y + 3]&.name == "rook" && board[x][y + 3].has_moved == false

    false
  end

  # Checks if queen side castling is legal
  def queen_side_is_legal?(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    return true if has_moved == false && in_check?(board, [x, y], color) == false &&
                   board[x][y - 1].nil? && in_check?(board, [x, y - 1], color) == false &&
                   board[x][y - 2].nil? && in_check?(board, [x, y - 2], color) == false &&
                   board[x][y - 4]&.name == "rook" && board[x][y - 4].has_moved == false &&
                   board[x][y - 3].nil?

    false
  end

  def update_move_status
    @has_moved = true
  end
end
