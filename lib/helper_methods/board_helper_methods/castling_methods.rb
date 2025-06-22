# Contains methods for castling
module Castling
  # rook and king in same place
  # none of the moves between are in check
  def when_castling(castle_side, king_cords, color) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    return if (color == "white" && king_cords != [0, 4]) || (color == "black" && king_cords != [7, 4])

    white_king_side_castling(king_cords, color) if castle_side == "king side" && color == "white"
    white_queen_side_castling(king_cords, color) if castle_side == "queen side" && color == "white"

    black_king_side_castling(king_cords, color) if castle_side == "king side" && color == "black"
    black_queen_side_castling(king_cords, color) if castle_side == "queen side" && color == "black"
  end

  def white_king_side_castling(king_cords, color)
    board[0]
  end

  def white_queen_side_castling(king_cords, color)
    # something
  end
end
