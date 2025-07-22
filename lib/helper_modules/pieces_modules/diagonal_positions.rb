# Has all the methods for getting all inline positons from a specific square (piece_cords)
module DiagonalPositions
  # All legal moves a bishop can make
  def possible_bishop_moves(board, piece_cords, color) # rubocop:disable Metrics/AbcSize
    possible_moves = left_upwards_positions(board, piece_cords[0], piece_cords[1], color).map { |cords| cords }
    right_upwards_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    left_downwards_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    right_downwards_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }

    possible_moves
  end

  # All diagonal moves upwards and to the left
  def left_upwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
    positions = []

    loop do
      piece_cords = [x += 1, y -= 1]
      break if x > 7 || y.negative? || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All diagonal moves upwards and to the right
  def right_upwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
    positions = []

    loop do
      piece_cords = [x += 1, y += 1]
      break if x > 7 || y > 7 || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All diagonal moves downwards and to the left
  def left_downwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
    positions = []

    loop do
      piece_cords = [x -= 1, y -= 1]
      break if x.negative? || y.negative? || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All diagonal moves downwards and to the right
  def right_downwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
    positions = []

    loop do
      piece_cords = [x -= 1, y += 1]
      break if x.negative? || y > 7 || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end
end
