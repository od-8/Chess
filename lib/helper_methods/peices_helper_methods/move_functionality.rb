# Move functions for peices
module MoveFunctions
  def legal_move?(peice_cords, move_cords)
    legal_moves = possible_positions(peice_cords)

    return true if legal_moves.include?(move_cords)

    false
  end

  def unocupided_square?(move_cords, peice)
    return true unless @board[move_cords[0]][move_cords[1]]&.color == peice.color

    false
  end
end
