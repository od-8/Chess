
# Contains all the methods for the queen peice
class Queen
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
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

  def possible_positions(peice_cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    all_possible_moves = []

    left_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    left_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    left_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_positions(peice_cords).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end
end
