require_relative "../helper_methods/peices_helper_methods/black_pawn_positions"

# Has the moves and info the the black pawn
class BlackPawn
  include BlackPawnPositions
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

  def legal_promotion?(row)
    return true if row.zero?

    false
  end

  def new_promotion_piece
    loop do
      puts "What piece would you like to promote to?"
      piece = gets.chomp.downcase
      return piece if %w[knight bishop rook queen].include?(piece)
    end
  end

  def promote # rubocop:disable Metrics/MethodLength
    piece = new_promotion_piece
    case piece
    when "knight"
      Knight.new("knight", "\u2658", "black")
    when "bishop"
      Bishop.new("bishop", "\u2657", "black")
    when "rook"
      Rook.new("rook", "\u2656", "black")
    when "queen"
      Queen.new("queen", "\u2655", "black")
    end
  end
end
