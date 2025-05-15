require_relative "move_functionality"

# Contains all the peices for the rook peice
class King
  include MoveFunctions
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

  def possible_positions(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []

    # All possible moves for king forward
    possible_moves << [x + 1, y] if (x + 1).between?(0, 7) && y.between?(0, 7)
    possible_moves << [x + 1, y - 1] if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x + 1, y + 1] if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)

    # All possible moves for king sideways
    possible_moves << [x, y - 1] if x.between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x, y + 1] if x.between?(0, 7) && (y + 1).between?(0, 7)

    # All possible moves for king backwards
    possible_moves << [x - 1, y] if (x - 1).between?(0, 7) && y.between?(0, 7)
    possible_moves << [x - 1, y - 1] if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x - 1, y + 1] if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)

    possible_moves
  end
end
