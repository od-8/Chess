# Has all the methods for pawn 1 forward, 2 forward and taking
module BlackPawnPositions
  # Method for basic pawn movement, up 1 square
  def black_move_one_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 1, y] if (x - 1).between?(0, 7) && board[x - 1][y].nil?

    all_possible_moves
  end

  # Method that allows pawn to move up 2 squares if they are on starting rank
  def black_move_two_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 2, y] if board[x - 1][y].nil? && x == 6 && board[x - 2][y].nil?

    all_possible_moves
  end

  # Allows black pawn to take up and across from itself
  def black_take_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize
    all_possible_moves = []

    all_possible_moves << [x - 1, y + 1] if board[x - 1][y + 1]&.color == "white"
    all_possible_moves << [x - 1, y - 1] if board[x - 1][y - 1]&.color == "white"

    all_possible_moves
  end
end
