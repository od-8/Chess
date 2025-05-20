require_relative "../helper_methods/peices_helper_methods/move_functionality"
require_relative "../helper_methods/peices_helper_methods/bishob_move_functionality"

# Contains all the methods for the bishop peices
class Bishop
  include MoveFunctions
  include BishopMoveMethods
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

  def possible_positions(peice_cords)
    all_possible_moves = []

    left_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    left_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end
end
