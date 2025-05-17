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
    result = possible_positions(peice_cords, move_cords)

    return true if result == true

    false
  end

  def unocupided_square?(move_cords, peice)
    return true unless @board[move_cords[0]][move_cords[1]]&.color == peice.color

    false
  end

  def possible_positions(peice_cords, move_cords)
    left_up = left_upwards?(peice_cords, move_cords)
    right_up = right_upwards?(peice_cords, move_cords)
    left_down = left_downwards?(peice_cords, move_cords)
    right_down = right_downwards?(peice_cords, move_cords)

    true if [left_up, right_up, left_down, right_down].any? { |result| result == true }
  end

  # Method that allows bishop to move upwards to the left
  def left_upwards?(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1] - 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  # Method that allows bishop to move upwards to the right
  def right_upwards?(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1] + 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  # Method that allows bishop to move downwards to the left
  def left_downwards?(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1] - 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  # Method that allows bishop to move downwards to the right
  def right_downwards?(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1] + 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end
end
