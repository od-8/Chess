require_relative "move_functionality"

# Contains all the methods for the pawn peice
class Pawn
  include MoveFunctions
  attr_accessor :symbol, :peice, :color

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end

  def move(peice_cords, move_cords, board, peice)
    if legal_move?(peice_cords, move_cords, peice) && unocupided_square?(move_cords[0], move_cords[1], peice, board)
      board[move_cords[0]][move_cords[1]] = peice
      board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    board
  end

  def legal_move?(peice_cords, move_cords, peice)
    legal_moves = possible_positions(peice_cords, peice)

    return true if legal_moves.include?([move_cords[0], move_cords[1]])

    false
  end

  def unocupided_square?(row, column, peice, board)
    return true unless board[row][column]&.color == peice.color

    false
  end

  def possible_positions(cords, peice) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []

    if peice.color == "white"
      possible_moves << [x + 1, y] if (x + 1).between?(0, 7) && y.between?(0, 7)
      possible_moves << [x + 2, y] if (x + 2).between?(0, 7) && y.between?(0, 7)
    end

    if peice.color == "black"
      possible_moves << [x - 1, y] if (x - 1).between?(0, 7) && y.between?(0, 7)
      possible_moves << [x - 2, y] if (x - 2).between?(0, 7) && y.between?(0, 7)
    end

    possible_moves
  end
end
