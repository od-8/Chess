require_relative "../helper_methods/peices_helper_methods/vertical_horizontal_algorithims"

# Contains all the methods for the rook peices
class Rook
  include VerticalHorizontalAlgorithims
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

    upwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    downwards_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    left_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    right_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end
end
