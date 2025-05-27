# Contains the vertical and horizontal methods for the bishop and queen

module VerticalHorizontalAlgorithims
  # All rook moves going straight up
  def upwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      peice_cords = [x += 1, y]
      break if x > 7 || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight down
  def downwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    positions = []

    loop do
      peice_cords = [x -= 1, y]
      break if x.negative? || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight to the left
  def left_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName
    positions = []

    loop do
      peice_cords = [x, y -= 1]
      break if y.negative? || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All rook moves going straight to the right
  def right_positions(board, x, y) # rubocop:disable Naming/MethodParameterName
    positions = []

    loop do
      peice_cords = [x, y += 1]
      break if y > 7 || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end
end
