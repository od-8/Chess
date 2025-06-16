require_relative "../helper_methods/peices_helper_methods/white_pawn_positions"

# Contains all the methods for the white pawns
class WhitePawn
  include PawnCapturing
  attr_accessor :name, :symbol, :color

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
  end

  def legal_move?(board, peice_cords, move_cords)
    legal_moves = pawn_move_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  # All legal moves a pawn can make
  def pawn_move_positions(board, peice_cords)
    all_possible_moves = []

    white_move_one_forward(peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    white_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    white_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end
end
