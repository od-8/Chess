# Contains all the peices for the rook peice
class King
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

  def in_check_positions?(cords)
    true if pawn_check(cords) || knight_check?(cords) || diagonal_check?(cords) || vertical_horizontal_check?(cords)
  end

  def pawn_check
    # do later
  end

  def knight_check?(peice_cords)
    # do later
  end

  def diagonal_check_check?(peice_cords)
    # do later
  end

  def vertical_horizontal_check?(peice_cords)
    # do later
  end
end
