# Handles the checking for threefold repetition
module ThreefoldRepetition
  # Checks if the same board has appeared three times
  def threefold_repetition?(fen_str)
    board_counter = 0

    previous_boards.each do |prev_board|
      board_counter += 1 if fen_str.split[0] == prev_board.split[0]
      return true if board_counter == 3
    end
    false
  end
end
