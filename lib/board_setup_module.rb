# Has all the methods to add all the peices to the board
module BoardSetup
  def add_peices
    add_king
    add_queen
    add_rooks
    add_bishops
    add_knights
    add_pawns
  end

  def add_king
    board[0][3] = King.new("k1", "white", "\u265a")
    board[7][3] = King.new("k1", "black", "\u2654")
  end

  def add_queen
    board[0][4] = Queen.new("q1", "white", "\u265b")
    board[7][4] = Queen.new("q1", "black", "\u2655")
  end

  def add_rooks
    board[0][0] = Rook.new("r1", "white", "\u265c")
    board[0][7] = Rook.new("r2", "white", "\u265c")
    board[7][0] = Rook.new("r1", "black", "\u2656")
    board[7][7] = Rook.new("r2", "black", "\u2656")
  end

  def add_bishops
    board[0][2] = Bishop.new("b1", "white", "\u265d")
    board[0][5] = Bishop.new("b2", "white", "\u265d")
    board[7][2] = Bishop.new("b1", "black", "\u2657")
    board[7][5] = Bishop.new("b2", "black", "\u2657")
  end

  def add_knights
    board[0][1] = Knight.new("k1", "white", "\u265e")
    board[0][6] = Knight.new("k1", "white", "\u265e")
    board[7][1] = Knight.new("k1", "black", "\u2658")
    board[7][6] = Knight.new("k1", "black", "\u2658")
  end

  def add_pawns
    8.times do |index = 0|
      board[1][index] = Pawn.new("p#{index}", "white", "\u265f")
      board[6][index] = Pawn.new("p#{index}", "black", "\u2659")
    end
  end
end
