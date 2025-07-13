# This just has all methdos the Game class calls on the Board class
# It makes reading game.rb easier and feel less clustered
module CallMethods
  # Checks to make sure the place the player would like to move their piece is empty
  def unnocupied_square?(piece, move_cords)
    board.unnocupied_square?(piece, move_cords)
  end

  # Checks if the player is in check
  def in_check?(board_arr, cords, color)
    board.in_check?(board_arr, cords, color)
  end

  # Checks if the player is in checkmate
  def in_checkmate?(king_cords, color)
    board.checkmate?(king_cords, color)
  end

  def insufficient_material?
    board.insufficient_material?
  end

  def threefold_repetition?
    board.threefold_repetition?(board.board)
  end
end
