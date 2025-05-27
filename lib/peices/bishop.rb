require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"

# Contains all the methods for the bishop peices
class Bishop
  include DiagonalAlgorithims
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
  end

  def legal_move?(board, peice_cords, move_cords)
    legal_moves = possible_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  def possible_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    all_possible_moves = []

    left_upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    left_downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  # # All bishop moves upwards and to the left
  # def left_upwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName,Metrics/CyclomaticComplexity
  #   positions = []

  #   loop do
  #     peice_cords = [x += 1, y -= 1]
  #     break if x > 7 || y.negative? || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All bishop moves upwards and to the right
  # def right_upwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
  #   positions = []

  #   loop do
  #     peice_cords = [x += 1, y += 1]
  #     break if x > 7 || y > 7 || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All bishop moves downwards and to the left
  # def left_downwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
  #   positions = []

  #   loop do
  #     peice_cords = [x -= 1, y -= 1]
  #     break if x.negative? || y.negative? || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All bishop moves downwards and to the right
  # def right_downwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName,Metrics/CyclomaticComplexity
  #   positions = []

  #   loop do
  #     peice_cords = [x -= 1, y += 1]
  #     break if x.negative? || y > 7 || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end
end
