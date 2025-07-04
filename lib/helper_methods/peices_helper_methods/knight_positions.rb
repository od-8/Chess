# Has the method which returns all the valid knight moves
module KnightPositions
  # All legal moves for the knight peice
  def possible_knight_moves(x, y) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Naming/MethodParameterName
    possible_moves = []

    # All the possible moves above where the night is currently
    possible_moves << [x + 1, y + 2] if (x + 1).between?(0, 7) && (y + 2).between?(0, 7)
    possible_moves << [x - 1, y + 2] if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)

    # All the possible moves below where the knight is currently
    possible_moves << [x + 1, y - 2] if (x + 1).between?(0, 7) && (y - 2).between?(0, 7)
    possible_moves << [x - 1, y - 2] if (x - 1).between?(0, 7) && (y - 2).between?(0, 7)

    # All the possible moves to the left of where the knight is currently
    possible_moves << [x - 2, y - 1] if (x - 2).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x - 2, y + 1] if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)

    # All the possible moves to the right of where the knight is currently
    possible_moves << [x + 2, y - 1] if (x + 2).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x + 2, y + 1] if (x + 2).between?(0, 7) && (y + 1).between?(0, 7)

    possible_moves
  end
end
