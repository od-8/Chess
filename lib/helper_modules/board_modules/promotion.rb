# Handles promotion. It checks if promotion is legal and makes a new piece depending on what the player asks for.
module Promotion
  # Gets the piece the player would like to promote to
  def ask_for_piece
    piece = nil

    loop do
      puts " What piece would you like to promote to"
      piece = gets.chomp.downcase
      break if legal_piece?(piece)
    end
    piece
  end

  # Checks if user input is a valid piece
  def legal_piece?(piece)
    return true if %w[queen rook bishop knight].include?(piece)

    false
  end

  # Returns the piece that the pawn promoted to or the passed piece if the pawn isnt promoting
  def promotion(piece, move_cords)
    return piece if (piece.color == "white" && move_cords[0] != 0) ||
                    (piece.color == "black" && move_cords[0] != 7)

    make_new_piece(ask_for_piece, piece.color)
  end

  def make_new_piece(piece, color)
    new_white_piece(piece) if color == "white"
    new_black_piece(piece) if color == "black"
  end

  def new_white_piece(piece)
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

  def new_black_piece(piece)
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
