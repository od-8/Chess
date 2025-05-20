require_relative "../helper_methods/peices_helper_methods/move_functionality"

# Contains all the methods for the knight peices
class Knight
  include MoveFunctions
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
    @board = nil
  end

  def move(board, peice, peice_cords, move_cords)
    @board = board
    if legal_move?(peice_cords, move_cords) && unocupided_square?(move_cords, peice)
      @board[move_cords[0]][move_cords[1]] = peice
      @board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    @board
  end

  def possible_positions(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
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
end
