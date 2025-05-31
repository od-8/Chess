require_relative "../helper_methods/peices_helper_methods/pawn_capturing"
require_relative "../helper_methods/peices_helper_methods/knight_positions"
require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains methods for king moving and check
class King
  include VerticalHorizontalAlgorithims
  include DiagonalAlgorithims
  include KnightPositions
  include PawnCapturing

  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(_board, piece_cords, move_cords)
    legal_moves = possible_positions(piece_cords[0], piece_cords[1])

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

  def in_check?(board, cords)
    puts "CHECK" if knight_check?(board, cords) || bishop_check?(board, cords)
  end

  # Checks if king is in check from kngiht
  def knight_check?(board, king_cords)
    knight_check_positions = possible_knight_moves(king_cords[0], king_cords[1])
    king = board[king_cords[0]][king_cords[1]]

    # Takes the current position of the king and check if there are any knight checking it
    knight_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "knight" && king.color != piece.color
    end

    false
  end

  # Checks if king is in check from bishop
  def bishop_check?(board, king_cords)
    bishop_check_positions = possible_bishop_moves(board, king_cords)
    king = board[king_cords[0]][king_cords[1]]

    bishop_check_positions.each do |check_position|
      piece = board[check_position[0]][check_position[1]]

      return true if piece&.name == "bishop" && king.color != piece.color
    end

    false
  end
end
