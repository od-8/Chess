# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  # Updates the pawns can_be_passanted status and passantable_pawn_cords
  def update_passantable_status(piece, piece_cords, move_cords)
    return unless piece.name == "pawn"

    set_passantable_status_to_false
    set_passantable_status_to_true(piece, piece_cords, move_cords)
  end

  # Sets the passantable pawns passantable status to false
  def set_passantable_status_to_false
    return if passantable_pawn_cords.nil?

    board[passantable_pawn_cords[0]][passantable_pawn_cords[1]].can_be_passanted = false
    @passantable_pawn_cords = nil
  end

  # Sets a pawns can be passanted status to true if the pawn just just moved moved forward twice
  def set_passantable_status_to_true(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    @passantable_pawn_cords = move_cords

    piece.can_be_passanted = true
  end

  # Removes the pawn that has been passanted
  def remove_passant_pawn(piece, piece_cords, move_cords)
    pawn_cords = piece.cords_of_passanted_pawn(board, piece_cords, move_cords)
    @board[pawn_cords[0]][pawn_cords[1]] = nil unless pawn_cords.nil?
  end
end
