require_relative "../helper_methods/peices_helper_methods/pawn_capturing"

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

    move_one_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    black_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }

    possible_moves
  end

  # Method for basic pawn movement, up 1 square
  def move_one_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 1, y] if (x - 1).between?(0, 7) && board[x][y].nil?

    all_possible_moves
  end

  # Method that allows pawn to move up 2 squares if they are on starting rank
  def move_two_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 2, y] if board[x - 1][y]&.color != color && x == 6

    all_possible_moves
  end
end
