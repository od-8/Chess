# Contains the vertical and horizontal algorithims
# Used for check, rook moving, queen moving
module VerticalHorizontalAlgorithims
  # All legal moves a rook can make
  def possible_rook_moves(board, piece_cords, color) # rubocop:disable Metrics/AbcSize
    possible_moves = []

    upwards_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    downwards_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    left_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }
    right_positions(board, piece_cords[0], piece_cords[1], color).each { |cords| possible_moves << cords }

    possible_moves
  end

  # All rook moves going straight up
  def upwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName
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
  def downwards_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName
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
  def left_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName
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
  def right_positions(board, x, y, color) # rubocop:disable Naming/MethodParameterName
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
