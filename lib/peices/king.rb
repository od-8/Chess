require_relative "../helper_methods/peices_helper_methods/pawn_capturing"
require_relative "../helper_methods/peices_helper_methods/knight_positions"
require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains methods for king moving and check
class King
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

  # def in_check?(board, cords)
  #   if pawn_check?(board, cords) || knight_check?(board, cords) || diagonal_check?(board, cords) || inline_check?(board, cords) # rubocop:disable Layout/LineLength
  #     true
  #   end
  # end

  # # Checks if king is in check from kngiht
  # def knight_check?(board, king_cords)
  #   knight_check_positions = possible_knight_moves(king_cords[0], king_cords[1])
  #   king = board[king_cords[0]][king_cords[1]]

  #   # Takes the current position of the king and check if there are any knight checking it
  #   knight_check_positions.each do |check_position|
  #     piece = board[check_position[0]][check_position[1]]

  #     return true if piece&.name == "knight" && king.color != piece.color
  #   end

  #   false
  # end

  # # Checks if king is in check from bishop
  # def diagonal_check?(board, king_cords)
  #   diagonal_check_positions = possible_bishop_moves(board, king_cords)
  #   king = board[king_cords[0]][king_cords[1]]

  #   diagonal_check_positions.each do |check_position|
  #     piece = board[check_position[0]][check_position[1]]

  #     return true if %w[bishop queen].include?(piece&.name) && king.color != piece.color
  #   end

  #   false
  # end

  # def inline_check?(board, king_cords)
  #   inline_check_positions = possible_rook_moves(board, king_cords)
  #   king = board[king_cords[0]][king_cords[1]]

  #   inline_check_positions.each do |check_position|
  #     piece = board[check_position[0]][check_position[1]]

  #     return true if %w[rook queen].include?(piece&.name) && king.color != piece.color
  #   end

  #   false
  # end

  # def pawn_check?(board, king_cords) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  #   king = board[king_cords[0]][king_cords[1]]
  #   pawn_check_positions = if king&.color == "white"
  #                            white_take_positions(board, king_cords[0], king_cords[1])
  #                          else
  #                            black_take_positions(board, king_cords[0], king_cords[1])
  #                          end

  #   pawn_check_positions.each do |check_position|
  #     piece = board[check_position[0]][check_position[1]]

  #     return true if piece&.name == "pawn" && king.color != piece.color
  #   end

  #   false
  # end

  # def checkmate?(board, king_cords)
  #   possible_moves = possible_positions(king_cords[0], king_cords[1])

  #   possible_moves.each do |move_cords|
      
  #   end
  # end
end
