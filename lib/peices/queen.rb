require_relative "../helper_methods/peices_helper_methods/diagonal_algorithims"
require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains all the methods for the queen peice
class Queen
  include DiagonalAlgorithims
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

  def possible_positions(board, peice_cords)
    all_possible_moves = []

    diagonal_posititions(board, peice_cords).each { |cords| all_possible_moves << cords }
    vertical_horizontal_positions(board, peice_cords).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  def diagonal_posititions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    all_possible_moves = []

    left_upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    left_downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  def vertical_horizontal_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    all_possible_moves = []

    upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    left_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end
end
