# Contains the diagonal methods for the bishop and queen
module DiagonalAlgorithims
  # All bishop moves upwards and to the left
  def left_upwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName,Metrics/CyclomaticComplexity
    positions = []

    loop do
      peice_cords = [x += 1, y -= 1]
      break if x > 7 || y.negative? || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All bishop moves upwards and to the right
  def right_upwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
    positions = []

    loop do
      peice_cords = [x += 1, y += 1]
      break if x > 7 || y > 7 || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All bishop moves downwards and to the left
  def left_downwards_positions(board, x, y) # rubocop:disable Naming/MethodParameterName,Metrics/AbcSize,Metrics/CyclomaticComplexity
    positions = []

    loop do
      peice_cords = [x -= 1, y -= 1]
      break if x.negative? || y.negative? || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end

  # All bishop moves downwards and to the right
  def right_downwards_positions(board, x, y) # rubocop:disable Metrics/AbcSize,Naming/MethodParameterName,Metrics/CyclomaticComplexity
    positions = []

    loop do
      peice_cords = [x -= 1, y += 1]
      break if x.negative? || y > 7 || board[x][y]&.color == color

      positions << peice_cords
      break if !board[x][y].nil? && board[x][y]&.color != color
    end

    positions
  end
end
