# This contains the methods for handling wether a game is over due to the fifty move rule
module FiftyMoveRule
  def fifty_move_rule?
    return true if @half_moves == 100

    false
  end

  def update_move_counters(piece, move_cords)
    update_half_moves(piece, move_cords)
    update_full_moves(piece)
  end

  def update_half_moves(piece, move_cords)
    if piece.name != "pawn" && board[move_cords[0]][move_cords[1]].nil?
      @half_moves += 1
    else
      @half_moves = 0
    end
  end

  def update_full_moves(piece)
    @full_moves += 1 if piece.color == "white"
  end
end
