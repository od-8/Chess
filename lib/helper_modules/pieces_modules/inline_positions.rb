# Has all the methods for getting all inline positons from a specific square (piece_cords)
module InlinePositions
  # All legal moves a rook can make
  def possible_inline_moves(board, piece_cords, color) # rubocop:disable Metrics/AbcSize
    possible_moves = north_moves(board, piece_cords[0], piece_cords[1], color).map { |cords| cords }
    south_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    west_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    east_moves(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }

    possible_moves
  end

  # All rook moves going straight up
  def north_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      piece_cords = [x += 1, y]
      break if x > 7 || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight down
  def south_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      piece_cords = [x -= 1, y]
      break if x.negative? || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight to the left
  def west_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      piece_cords = [x, y -= 1]
      break if y.negative? || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight to the right
  def east_moves(board, x, y, color) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      piece_cords = [x, y += 1]
      break if y > 7 || board[x][y]&.color == color

      positions << piece_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end
end
