# Contains all the methods for the knight peices
class Knight
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
  end

  def legal_move?(_board, _peice, peice_cords, move_cords)
    legal_moves = possible_positions(peice_cords[0], peice_cords[1])

    return true if legal_moves.include?(move_cords)

    false
  end

  def possible_positions(x, y) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Naming/MethodParameterName
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
