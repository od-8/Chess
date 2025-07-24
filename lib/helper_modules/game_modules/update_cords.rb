# Contains all methods that are used when updating coordinates
module UpdateCords
  # Updates the coordinates of the king
  def update_king_cords(piece, move_cords)
    return unless piece.name == "king"

    piece.color == "white" ? @white_king_cords = move_cords : @black_king_cords = move_cords
  end

  # Updates turn from player 1 to player 2
  def update_current_player
    @current_player = current_player == player1 ? player2 : player1
  end

  # The current king is the king corresponding to the current player
  # If the current player has the white pieces then the current king is the white king
  def update_current_king
    @current_king = if @current_king == [white_king_cords, "white"]
                      [black_king_cords, "black"]
                    else
                      [white_king_cords, "white"]
                    end
  end

  # This handles an issue when preforming an invalid move with the king then moving any other piece including the king
  # The king cords would be updated but then wouldnt be reset resulting in the game thinking the king is in the invalid
  # square. This method returns the move cords if the piece being moved is the king, or the current kings cords if the
  # piece being moved is not a king
  def handle_king_cords(piece, move_cords)
    return move_cords if piece.name == "king"

    current_king[0]
  end
end
