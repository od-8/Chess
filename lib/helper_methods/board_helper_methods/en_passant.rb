# Has the methods that handle en passant, checking if its leagl, removing the previous peice, moving to an empty square
module EnPassant
  def en_passant(piece, piece_cords, move_cords)
    return unless piece_cords[0] + 2 == move_cords[0] ||
                  piece_cords[0] - 2 == move_cords[0]

    left_passant(piece.color, move_cords[0], move_cords[1])
    right_passant(piece.color, move_cords[0], move_cords[1])
  end

  def left_passant(color, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    level(color, x)

    board[x][y - 1].left_passant = true if board[level(color, x)][y].nil? &&
                                           board[x][y - 1]&.name == "pawn" &&
                                           board[x][y - 1].color != color
  end

  def right_passant(color, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    board[x][y + 1].right_passant = true if board[level(color, x)][y].nil? &&
                                            board[x][y + 1]&.name == "pawn" &&
                                            board[x][y + 1].color != color
  end

  def level(color, x) # rubocop:disable Naming/MethodParameterName
    color == "black" ? x + 1 : x - 1
  end
end
