require_relative "../helper_methods/peices_helper_methods/pawn_capturing"

# Contains all the methods for the black pawns
class BlackPawn
  include PawnCapturing
  attr_accessor :peice, :color

  def initialize(piece, color)
    @peice = piece
    @color = color
  end

  def legal_move?(board, peice_cords, move_cords)
    legal_moves = possible_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  def possible_positions(board, peice_cords)
    all_possible_moves = []

    forward_positions(peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    double_forward_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    black_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  def forward_positions(x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 1, y] if (x - 1).between?(0, 7)

    all_possible_moves
  end

  def double_forward_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 2, y] if board[x - 1][y]&.color != color && x == 6

    all_possible_moves
  end
end
