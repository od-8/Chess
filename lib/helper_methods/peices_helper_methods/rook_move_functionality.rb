# Move functions for the rook
module RookMoveMethods
  def upwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1]]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if peice_cords[0] > 7 || @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  def downwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1]]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if peice_cords[0].negative? || @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  def left_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0], peice_cords[1] - 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if peice_cords[0] > 7 || @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  def right_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0], peice_cords[1] + 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if peice_cords[1] > 7 || @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end
end
