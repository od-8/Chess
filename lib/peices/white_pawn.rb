require_relative "../helper_methods/peices_helper_methods/white_pawn_positions"

# Contains all the methods for the white pawns
class WhitePawn
  include WhitePawnMovement
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

    white_move_one_forward(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    white_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }
    white_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  def legal_promotion?(row)
    return true if row == 7

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
      Knight.new("knight", "\u265e", "white")
    when "bishop"
      Bishop.new("bishop", "\u265d", "white")
    when "rook"
      Rook.new("rook", "\u265c", "white")
    when "queen"
      Queen.new("queen", "\u265b", "white")
    end
  end
end
