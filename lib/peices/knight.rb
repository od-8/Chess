# Contains all the methods for the knight peices
class Knight
  attr_accessor :symbol, :peice, :color

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end

  def move(peice_cords, move_cords, board, peice)
    if legal_move?(peice_cords, move_cords) && unocupided_square?(move_cords[0], move_cords[1], peice, board)
      board[move_cords[0]][move_cords[1]] = peice
      board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    board
  end

  def legal_move?(peice_cords, move_cords)
    legal_moves = possible_position(peice_cords)
    return true if legal_moves.include?([move_cords[0], move_cords[1]])

    false
  end

  def possible_position(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
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

  def unocupided_square?(row, column, peice, board)
    return true unless board[row][column]&.color == peice.color

    false
  end
end
