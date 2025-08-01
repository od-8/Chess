# Has all the methods for pawn 1 forward, 2 forward, taking and en passant
module WhitePawnPositions
  # All legal moves a pawn can make
  def white_pawn_positions(board, peice_cords) # rubocop:disable Metrics/AbcSize
    possible_moves = white_move_one_forward(board, peice_cords[0], peice_cords[1]).map { |cords| cords }
    white_move_two_forward(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    white_take_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }
    en_passant_positions(board, peice_cords[0], peice_cords[1]).each { |cords| possible_moves << cords }

    possible_moves
  end

  # Method for basic pawn movement, up 1 square
  def white_move_one_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    all_possible_moves = []

    all_possible_moves << [x - 1, y] if (x - 1).between?(0, 7) && board[x - 1][y].nil?

    all_possible_moves
  end

  # Method that allows pawn to move up 2 squares if they are on starting rank
  def white_move_two_forward(board, x, y) # rubocop:disable Naming/MethodParameterName
    possible_moves = []

    possible_moves << [x - 2, y] if board[x - 1][y].nil? && x == 6 && board[x - 2][y].nil?

    possible_moves
  end

  # Allows white pawn to take up and across from itself
  def white_take_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize
    all_possible_moves = []

    all_possible_moves << [x - 1, y + 1] if board[x - 1][y + 1]&.color == "black"
    all_possible_moves << [x - 1, y - 1] if board[x - 1][y - 1]&.color == "black"

    all_possible_moves
  end

  # Allows white pawn to en passant if its legal
  def en_passant_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
    possible_moves = []
    possible_moves << [x - 1, y + 1] if en_passant_legal?(board, x, y + 1)
    possible_moves << [x - 1, y - 1] if en_passant_legal?(board, x, y - 1)
    possible_moves
  end

  # Checks if en passant is legal
  def en_passant_legal?(board, x, y) # rubocop:disable Naming/MethodParameterName
    return true if board[x - 1][y].nil? &&
                   board[x][y]&.name == "pawn" &&
                   board[x][y].color == "black" &&
                   board[x][y].can_be_passanted == true

    false
  end
end
