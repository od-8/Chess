require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains all the methods for the rook peices
class Rook
  include VerticalHorizontalAlgorithims
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
  end

  def legal_move?(board, _peice, peice_cords, move_cords)
    legal_moves = possible_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  def possible_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    all_possible_moves = []

    upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    left_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  # # All rook moves going straight up
  # def upwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
  #   positions = []

  #   loop do
  #     peice_cords = [x += 1, y]
  #     break if x > 7 || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All rook moves going straight down
  # def downwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
  #   positions = []

  #   loop do
  #     peice_cords = [x -= 1, y]
  #     break if x.negative? || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All rook moves going straight to the left
  # def left_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
  #   positions = []

  #   loop do
  #     peice_cords = [x, y -= 1]
  #     break if y.negative? || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end

  # # All rook moves going straight to the right
  # def right_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
  #   positions = []

  #   loop do
  #     peice_cords = [x, y += 1]
  #     break if y > 7 || board[x][y]&.color == color

  #     positions << peice_cords
  #     break if !board[x][y].nil? && board[x][y]&.color != color
  #   end

  #   positions
  # end
end
