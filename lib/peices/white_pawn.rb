require_relative "../helper_methods/peices_helper_methods/white_pawn_positions"

# Has the moves and info for the whtie pawn
class WhitePawn
  include WhitePawnPositions
  attr_accessor :name, :symbol, :color, :can_be_passanted

  def initialize(name, symbol, color)
    @name = name
    @symbol = symbol
    @color = color
    @can_be_passanted = false
  end

  # Checks if the white pawn can move to where the player wants it to move
  def legal_move?(board, peice_cords, move_cords)
    legal_moves = pawn_move_positions(board, peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  # All legal moves a pawn can make
  def pawn_move_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    possible_moves = white_move_one_forward(board, peice_cords[0], peice_cords[1]).map { |cords| cords }
    white_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    white_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    en_passant_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }

    possible_moves
  end

  # Checks if en passant is the move and returns the coordinates of the piece that need to be removed
  def remove_passant_pawn(board, piece_cords, move_cords)
    return unless
        board[move_cords[0]][move_cords[1]].nil? &&
        [[piece_cords[0] + 1, piece_cords[1] - 1], [piece_cords[0] + 1, piece_cords[1] + 1]].include?(move_cords)

    [piece_cords[0], move_cords[1]]
  end
end
