# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  # Sets a pawns can be passanted status to true if the board just did a double forward
  def en_passant(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    @passantable_pawn_cords = move_cords

    piece.can_be_passanted = true
  end

  # Removes the pawn that has been passanted
  def remove_passant_pawn(piece, piece_cords, move_cords)
    remove_cords = piece.remove_passant_pawn(board, piece_cords, move_cords)
    @board[remove_cords[0]][remove_cords[1]] = nil unless remove_cords.nil?
  end

  # Sets the passantable pawns passantable status to false
  def update_passantable_pawn
    return if passantable_pawn_cords.nil?

    board[passantable_pawn_cords[0]][passantable_pawn_cords[1]].can_be_passanted = false
    @passantable_pawn_cords = nil
  end
end
