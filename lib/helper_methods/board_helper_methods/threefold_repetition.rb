# Handles all the details for threefold repetition
module ThreefoldRepetition
  def threefold_repetition?(board)
    fen_board = convert_to_fen(board)
    board_counter = 0

    previous_boards.each do |prev_board|
      board_counter += 1 if fen_board == prev_board
      return true if board_counter == 3
    end
    false
  end
end
