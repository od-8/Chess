# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  def en_passant(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    @passantable_pawn = piece

    piece.can_be_passanted = true
  end

  # Removes the passantable pawn
  def remove_passant_pawn(piece, piece_cords, move_cords)
    remove_cords = piece.remove_passant_pawn(board, piece_cords, move_cords)
    @board[remove_cords[0]][remove_cords[1]] = nil unless remove_cords.nil?
  end

  # Sets the passantablee pawns passantable status to false
  def update_passantable_pawn
    return if @passantable_pawn.nil?

    @passantable_pawn.can_be_passanted = false
  end
end
