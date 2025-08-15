# This contains the methods for handling wether a game is over due to the fifty move rule
module FiftyMoveRule
  # Updates the move counter
  def update_move_counters(piece, move_cords)
    update_half_moves(piece, move_cords)
    update_full_moves(piece)
  end

  # Increments half move if the piece being moved is capturing and isnt a pawn
  def update_half_moves(piece, move_cords)
    if piece.name != "pawn" && board[move_cords[0]][move_cords[1]].nil?
      @half_moves += 1
    else
      @half_moves = 0
    end
  end

  # Increments full moves
  def update_full_moves(piece)
    @full_moves += 1 if piece.color == "white"
  end
end
