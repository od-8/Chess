# Contains all the methods for the bishop peices
class Bishop
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
    @board = nil
  end

  def move(board, peice, peice_cords, move_cords)
    @board = board
    if legal_move?(peice_cords, move_cords) && unocupided_square?(move_cords, peice)
      @board[move_cords[0]][move_cords[1]] = peice
      @board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    @board
  end

  def legal_move?(peice_cords, move_cords)
    legal_moves = possible_positions(peice_cords)

    return true if legal_moves.include?([move_cords[0], move_cords[1]])

    false
  end

  def unocupided_square?(move_cords, peice)
    return true unless @board[move_cords[0]][move_cords[1]]&.color == peice.color

    false
  end

  def possible_positions(peice_cords)
    all_possible_moves = []

    left_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_upwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    left_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }
    right_downwards_positions(peice_cords).each { |cords| all_possible_moves << cords }

    all_possible_moves
  end

  # Returns all bishop moves upwards and to the left [x + 1, y - 1]
  def left_upwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1] - 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  # Returns all bishop moves upwards and to the right [x + 1, y + 1]
  def right_upwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1] + 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if peice_cords[0] > 7 || @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  # Returns all bishop moves downwards and to the left [x - 1, y - 1]
  def left_downwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1] - 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end

  # # Returns all bishop moves downwards and to the right [x - 1, y + 1]
  def right_downwards_positions(peice_cords) # rubocop:disable Metrics/AbcSize
    positions = []
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1] + 1]
      # Breaks if it reaches target point or reaches one of its own color peices
      break if @board[peice_cords[0]][peice_cords[1]]&.color == color

      positions << peice_cords
      # Breaks if the peice is not nil and is not the same color, e.x if white bishop, breaks if color of peice is black
      break if !@board[peice_cords[0]][peice_cords[1]].nil? && @board[peice_cords[0]][peice_cords[1]]&.color != color
    end
    positions
  end
end
