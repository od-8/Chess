# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  def en_passant(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    left_pawn_passant(piece.color, move_cords[0], move_cords[1])
    right_pawn_passant(piece.color, move_cords[0], move_cords[1])
  end

  def left_pawn_passant(color, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    level(color, x)

    board[x][y - 1].right_passant = true if board[level(color, x)][y].nil? &&
                                            board[x][y - 1]&.name == "pawn" &&
                                            board[x][y - 1].color != color
  end

  def right_pawn_passant(color, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    level(color, x)

    board[x][y + 1].left_passant = true if board[level(color, x)][y].nil? &&
                                           board[x][y + 1]&.name == "pawn" &&
                                           board[x][y + 1].color != color
  end

  def level(color, x) # rubocop:disable Naming/MethodParameterName
    color == "black" ? x + 1 : x - 1
  end

  def remove_passant_pawn(piece, piece_cords, move_cords)
    remvoe_black_piece(piece_cords, move_cords) if piece.color == "white"
    remvoe_white_piece(piece_cords, move_cords) if piece.color == "black"
  end

  def remvoe_black_piece(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    @board[piece_cords[0]][piece_cords[1] - 1] = nil if move_cords == [piece_cords[0] + 1, piece_cords[1] - 1]
    @board[piece_cords[0]][piece_cords[1] + 1] = nil if move_cords == [piece_cords[0] + 1, piece_cords[1] + 1]
  end

  def remvoe_white_piece(piece_cords, move_cords) # rubocop:disable Metrics/AbcSize
    @board[piece_cords[0]][piece_cords[1] - 1] = nil if move_cords == [piece_cords[0] - 1, piece_cords[1] - 1]
    @board[piece_cords[0]][piece_cords[1] + 1] = nil if move_cords == [piece_cords[0] - 1, piece_cords[1] + 1]
  end
end
