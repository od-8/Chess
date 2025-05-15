# Move functions for peices
module MoveFunctions
  def legal_move?(peice_cords, move_cords)
    legal_moves = possible_positions(peice_cords)

    return true if legal_moves.include?([move_cords[0], move_cords[1]])

    false
  end

  def unocupided_square?(row, column, peice, board)
    return true unless board[row][column]&.color == peice.color

    false
  end
end
