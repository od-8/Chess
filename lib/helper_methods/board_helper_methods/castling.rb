# Has all the methods for castling including checking if castling is legal and moving the rook.
# The king movement is handled with Board#move.
module Castling
  # Checks if the king is castling
  def castling(piece_cords, move_cords)
    king_side = move_cords[1] == piece_cords[1] + 2
    queen_side = move_cords[1] == piece_cords[1] - 2

    return unless king_side == true || queen_side == true

    castle_king_side(piece_cords) if king_side == true
    castle_queen_side(piece_cords) if queen_side == true
  end

  def castle_king_side(piece_cords)
    # Moves the queen side rook to the correct position
    rook = board[piece_cords[0]][piece_cords[1] + 3]

    @board[piece_cords[0]][piece_cords[1] + 1] = rook
    @board[piece_cords[0]][piece_cords[1] + 3] = nil
  end

  # Moves the queen side rook to the correct position
  def castle_queen_side(piece_cords)
    rook = board[piece_cords[0]][piece_cords[1] - 4]

    @board[piece_cords[0]][piece_cords[1] - 1] = rook
    @board[piece_cords[0]][piece_cords[1] - 4] = nil
  end
end
