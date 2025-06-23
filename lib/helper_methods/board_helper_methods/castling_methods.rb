# Contains methods for castling
module Castling
  # rook and king in same place
  # none of the moves between are in check
  def castling_is_legal(castle_side, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/AbcSize
    return true if castle_side == "king side" && color == "white" && legal_castling?([0, 5], [0, 6], [0, 7], "white")
    return true if castle_side == "queen side" && color == "white" && legal_castling?([0, 3], [0, 2], [0, 0], "white")

    return true if castle_side == "king side" && color == "black" && legal_castling?([7, 5], [7, 6], [7, 7], "black")
    return true if castle_side == "queen side" && color == "black" && legal_castling?([7, 3], [7, 2], [7, 0], "black")

    false
  end

  def legal_castling?(one, two, rook, color) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity
    return true if white_king_moved == false &&
                   board[one[0]][one[1]].nil? && in_check?(one, color) == false &&
                   board[two[0]][two[1]].nil? && in_check?(two, color) == false &&
                   board[rook[0]][rook[1]].name == "rook" && board[rook[0]][rook[1]].color == color

    false
  end

  def castling_move(castle_side, color) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    move_castle_pieces([0, 4], [0, 7], [0, 6], [0, 5]) if castle_side == "king side" && color == "white"
    move_castle_pieces([0, 4], [0, 0], [0, 2], [0, 3]) if castle_side == "queen side" && color == "white"

    move_castle_pieces([7, 4], [7, 7], [7, 6], [7, 5]) if castle_side == "king side" && color == "black"
    move_castle_pieces([7, 4], [7, 0], [7, 2], [7, 3]) if castle_side == "queen side" && color == "black"
  end

  def move_castle_pieces(king, rook, king_move, rook_move) # rubocop:disable Metrics/AbcSize
    king_piece = board[king[0]][king[1]]
    rook_piece = board[rook[0]][rook[1]]

    @board[king_move[0]][king_move[1]] = king_piece
    @board[rook_move[0]][rook_move[1]] = rook_piece
    @board[king[0]][king[1]] = nil
    @board[rook[0]][rook[1]] = nil
  end
end
