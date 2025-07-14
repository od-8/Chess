# Handles the checking for threefold repetition
module ThreefoldRepetition
  # Checks if the same board has appeared three times
  def threefold_repetition?(board)
    fen_board = fen_board(board)
    board_counter = 0

    previous_boards.each do |prev_board|
      board_counter += 1 if fen_board == prev_board
      return true if board_counter == 3
    end
    false
  end
end
