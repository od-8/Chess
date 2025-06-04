# Contains the method for where the king can move to
# Used for king moving
module KingPositions
  def possible_king_moves(x, y) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Naming/MethodParameterName
    possible_moves = []

    # All possible moves for king forward
    possible_moves << [x + 1, y] if (x + 1).between?(0, 7)
    possible_moves << [x + 1, y - 1] if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x + 1, y + 1] if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)

    # All possible moves for king sideways
    possible_moves << [x, y - 1] if (y - 1).between?(0, 7)
    possible_moves << [x, y + 1] if (y + 1).between?(0, 7)

    # All possible moves for king backwards
    possible_moves << [x - 1, y] if (x - 1).between?(0, 7)
    possible_moves << [x - 1, y - 1] if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x - 1, y + 1] if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)

    possible_moves
  end
end
