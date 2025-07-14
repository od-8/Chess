# Adds all the pieces to the board.
module AddPieces
  def add_peices
    add_king
    # add_queen
    # add_rooks
    # add_bishops
    # add_knights
    add_pawns
  end

  def add_king
    board[0][4] = King.new("king", "\u265a", "white")
    board[7][4] = King.new("king", "\u2654", "black")
  end

  def add_queen
    board[0][3] = Queen.new("queen", "\u265b", "white")
    board[7][3] = Queen.new("queen", "\u2655", "black")
  end

  def add_rooks
    board[0][0] = Rook.new("rook", "\u265c", "white")
    board[0][7] = Rook.new("rook", "\u265c", "white")
    board[7][0] = Rook.new("rook", "\u2656", "black")
    board[7][7] = Rook.new("rook", "\u2656", "black")
  end

  def add_bishops
    board[0][2] = Bishop.new("bishop", "\u265d", "white")
    board[0][5] = Bishop.new("bishop", "\u265d", "white")
    board[7][2] = Bishop.new("bishop", "\u2657", "black")
    board[7][5] = Bishop.new("bishop", "\u2657", "black")
  end

  def add_knights
    board[0][1] = Knight.new("knight", "\u265e", "white")
    board[0][6] = Knight.new("knight", "\u265e", "white")
    board[7][1] = Knight.new("knight", "\u2658", "black")
    board[7][6] = Knight.new("knight", "\u2658", "black")
  end

  def add_pawns
    8.times do |index = 0|
      board[1][index] = WhitePawn.new("pawn", "\u265f", "white")
      board[6][index] = BlackPawn.new("pawn", "\u2659", "black")
    end
  end
end
