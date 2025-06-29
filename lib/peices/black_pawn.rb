require_relative "../helper_methods/peices_helper_methods/black_pawn_positions"

# Contains all the methods for the black pawns
class BlackPawn
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
    possible_moves = []

    black_move_one_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    black_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    black_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }

    possible_moves
  end
end
