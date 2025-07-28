# This just has all methdos the Game class calls on the Board class
# It makes reading game.rb easier and feel less clustered
module CallMethods
  # Updates the previous boards instance variable in Board
  def update_prev_board(color)
    board.update_previous_board(color)
  end

  # Moves the piece
  def move(piece, piece_cords, move_cords)
    board.move(piece, piece_cords, move_cords)
  end

  # Print the board
  def print_board
    board.print_board
  end

  # Checks to make sure the place the player would like to move their piece is empty
  def unnocupied_square?(piece, move_cords)
    board.unnocupied_square?(piece, move_cords)
  end

  # Checks if the player is in check
  def in_check?(board_arr, color)
    board.in_check?(board_arr, color)
  end

  # Checks if the player is in checkmate
  def in_checkmate?(color)
    board.in_checkmate?(color)
  end

  # Checks if there arent enough pieces
  def checkmate_isnt_possible?
    board.insufficient_material?
  end

  # Checks if the same board has appeared three times
  def draw_by_repetition?
    board.threefold_repetition?
  end
end
