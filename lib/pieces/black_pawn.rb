require_relative "../helper_modules/pieces_modules/black_pawn_positions"

# Has the moves and info the the black pawn piece
class BlackPawn
  include BlackPawnPositions
  attr_accessor :name, :symbol, :color, :can_be_passanted

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
    @can_be_passanted = false
  end

  # Checks if the black pawn can move to where the player wants it to move
  def legal_move?(board, peice_cords, move_cords)
    legal_moves = black_pawn_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  # Checks if en passant is the move and returns the coordinates of the piece that need to be removed
  def cords_of_passanted_pawn(board, piece_cords, move_cords)
    return unless
        board[move_cords[0]][move_cords[1]].nil? &&
        [[piece_cords[0] + 1, piece_cords[1] - 1], [piece_cords[0] + 1, piece_cords[1] + 1]].include?(move_cords)

    [piece_cords[0], move_cords[1]]
  end
end
