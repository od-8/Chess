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
    board[0][3] = King.new("\u265a", "white")
    board[7][3] = King.new("\u2654", "black")
  end

  def add_queen
    board[0][4] = Queen.new("\u265b", "white")
    board[7][4] = Queen.new("\u2655", "black")
  end

  def add_rooks
    board[0][0] = Rook.new("\u265c", "white")
    board[0][7] = Rook.new("\u265c", "white")
    board[7][0] = Rook.new("\u2656", "black")
    board[7][7] = Rook.new("\u2656", "black")
  end

  def add_bishops
    board[0][2] = Bishop.new("\u265d", "white")
    board[0][5] = Bishop.new("\u265d", "white")
    board[7][2] = Bishop.new("\u2657", "black")
    board[7][5] = Bishop.new("\u2657", "black")
  end

  def add_knights
    board[0][1] = Knight.new("\u265e", "white")
    board[0][6] = Knight.new("\u265e", "white")
    board[7][1] = Knight.new("\u2658", "black")
    board[7][6] = Knight.new("\u2658", "black")
  end

  def add_pawns
    8.times do |index = 0|
      board[1][index] = WhitePawn.new("\u265f", "white")
      board[6][index] = BlackPawn.new("\u2659", "black")
    end
  end
end
