# Handles promtoion from getting the piece the player would like to promte to and actually adding it to the board
module Promotion
  def ask_for_piece
    piece = nil

    loop do
      puts "What piece would you like to promote to"
      piece = gets.chomp.downcase
      break if legal_piece?(piece)
    end
    piece
  end

  def legal_piece?(piece)
    return true if %w[queen rook bishop knight].include?(piece)

    false
  end

  def promotion(color, move_cords)
    return if (color == "white" && move_cords[0] != 7) || (color == "black" && move_cords[0] != 0)

    make_new_piece(ask_for_piece, color, move_cords)
  end

  def make_new_piece(piece, color, move_cords) # rubocop:disable Metrics/AbcSize
    case piece
    when "queen"
      @board[move_cords[0]][move_cords[1]] = Queen.new("queen", "\u265b", color)
    when "rook"
      @board[move_cords[0]][move_cords[1]] = Rook.new("rook", "\u265b", color)
    when "bishop"
      @board[move_cords[0]][move_cords[1]] = Bishop.new("bishop", "\u265b", color)
    when "kngight"
      @board[move_cords[0]][move_cords[1]] = Knight.new("knight", "\u265b", color)
    end
  end
end
