# Move methods for the pawn
module PawnMoveFunctions
  def white_take(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x + 1, y - 1] if (x + 1).between?(0, 7) && (y - 1).between?(0, 7) && @board[x + 1][y - 1]&.color == "black"
    possible_moves << [x + 1, y + 1] if (x + 1).between?(0, 7) && (y + 1).between?(0, 7) && @board[x + 1][y + 1]&.color == "black"
    possible_moves
  end

  # Taking method for black peices
  def black_take(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x - 1, y - 1] if (x - 1).between?(0, 7) && (y - 1).between?(0, 7) && @board[x - 1][y - 1]&.color == "white"
    possible_moves << [x - 1, y + 1] if (x - 1).between?(0, 7) && (y + 1).between?(0, 7) && @board[x - 1][y + 1]&.color == " white"
    possible_moves
  end
end
