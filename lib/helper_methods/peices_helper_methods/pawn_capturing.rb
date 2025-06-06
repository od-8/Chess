# Contains the methods for pawn capturing
# Used for check and pawn capturing
module PawnCapturing
  # Allows white pawn to take up and across from itself
  def white_take_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize
    all_possible_moves = []

    all_possible_moves << [x + 1, y + 1] if board[x + 1][y + 1]&.color == "black"
    all_possible_moves << [x + 1, y - 1] if board[x + 1][y - 1]&.color == "black"

    all_possible_moves
  end

  # Allows black pawn to take up and across from itself
  def black_take_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize
    all_possible_moves = []

    all_possible_moves << [x - 1, y + 1] if board[x - 1][y + 1]&.color == "white"
    all_possible_moves << [x - 1, y - 1] if board[x - 1][y - 1]&.color == "white"

    all_possible_moves
  end
end
