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

  def promotion(piece, move_cords)
    return piece if piece.color == "white" && move_cords[0] != 7 ||
                    piece.color == "black" && move_cords[0] != 0

    make_new_piece(ask_for_piece, piece.color)
  end

  def make_new_piece(piece, color)
    case piece
    when "queen"
      Queen.new("queen", "\u265b", color)
    when "rook"
      Rook.new("rook", "\u265b", color)
    when "bishop"
      Bishop.new("bishop", "\u265b", color)
    when "kngight"
      Knight.new("knight", "\u265b", color)
    end
  end
end
