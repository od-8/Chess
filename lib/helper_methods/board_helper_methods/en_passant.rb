# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  # def en_passant(piece, piece_cords, move_cords)
  #   return unless piece_cords[0] + 2 == move_cords[0] ||
  #                 piece_cords[0] - 2 == move_cords[0]

  #   left_pawn_passant(piece.color, move_cords[0], move_cords[1])
  #   right_pawn_passant(piece.color, move_cords[0], move_cords[1])
  # end

  # def left_pawn_passant(color, x, y)
  #   level(color, x)

  #   board[x][y - 1].right_passant = true if board[level(color, x)][y].nil? &&
  #                                           board[x][y - 1]&.name == "pawn" &&
  #                                           board[x][y - 1].color != color
  # end

  # def right_pawn_passant(color, x, y)
  #   level(color, x)

  #   board[x][y + 1].left_passant = true if board[level(color, x)][y].nil? &&
  #                                          board[x][y + 1]&.name == "pawn" &&
  #                                          board[x][y + 1].color != color
  # end

  # def level(color, x)
  #   color == "black" ? x + 1 : x - 1
  # end

  def en_passant(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    @passantable_pawn = piece

    piece.can_be_passanted = true
  end

  def remove_passant_pawn(piece, piece_cords, move_cords)
    remove_cords = piece.remove_passant_pawn(board, piece_cords, move_cords)
    @board[remove_cords[0]][remove_cords[1]] = nil unless remove_cords.nil?
  end

  def update_passantable_pawn
    return if @passantable_pawn.nil?

    @passantable_pawn.can_be_passanted = false
  end
end
