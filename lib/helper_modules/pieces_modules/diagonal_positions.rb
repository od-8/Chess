# Has all the methods for getting all inline positons from a specific square (piece_cords)
module DiagonalPositions
  # All legal moves a bishop can make
  def possible_diagonal_moves(board, piece_cords, color) # rubocop:disable Metrics/AbcSize
    possible_moves = north_west_moves(board, piece_cords[0], piece_cords[1], color).map { |cords| cords }
    north_east_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    south_west_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    south_east_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }

    possible_moves
  end

  # All diagonal moves upwards and to the left
  def north_west_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
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
  def north_east_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
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
  def south_west_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
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
  def south_east_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName,Metrics/CyclomaticComplexity
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
