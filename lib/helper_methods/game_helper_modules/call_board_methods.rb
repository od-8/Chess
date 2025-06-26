# Contians all the methods where game is just calling a board method
module BoardMethods
  # Checks to make sure the place the player would like to move their piece is empty
  def unnocupied_square?(piece, move_cords)
    board.unnocupied_square?(piece, move_cords)
  end

  # Checks if the player is in check
  def in_check?(cords, color)
    board.in_check?(cords, color)
  end

  # Checks if the player is in checkmate
  def in_checkmate?(king_cords, color)
    board.checkmate?(king_cords, color)
  end
end
