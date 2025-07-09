require_relative "../helper_methods/peices_helper_methods/white_pawn_positions"

# Has the moves and info for the whtie pawn
class WhitePawn
  include WhitePawnPositions
  attr_accessor :name, :symbol, :color, :left_passant, :right_passant

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
    @right_passant = false
    @left_passant = false
  end

  def legal_move?(board, peice_cords, move_cords)
    legal_moves = pawn_move_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  # All legal moves a pawn can make
  def pawn_move_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    possible_moves = []

    white_move_one_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    white_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    white_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    en_passant_positions(peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }

    possible_moves
  end

  def en_passant_positions(x, y) # rubocop:disable Naming/MethodParameterName
    p left_passant
    p right_passant
    puts ""
    possible_moves = []
    possible_moves << [x + 1, y + 1] if right_passant == true
    possible_moves << [x + 1, y - 1] if left_passant == true
    @left_passant = false
    @right_passant = false
    possible_moves
  end
end
