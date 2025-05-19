# Contains all the methods for the rook peices
class Rook
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
    up = upwards(peice_cords, move_cords)
    down = downwards(peice_cords, move_cords)
    left = left(peice_cords, move_cords)
    right = right(peice_cords, move_cords)

    true if [up, down, left, right].any? { |result| result == true }
  end

  def upwards(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] + 1, peice_cords[1]]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  def downwards(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0] - 1, peice_cords[1]]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  def left(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0], peice_cords[1] - 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end

  def right(peice_cords, move_cords)
    loop do
      peice_cords = [peice_cords[0], peice_cords[1] + 1]
      return true if peice_cords == move_cords
      break unless @board[peice_cords[0]][peice_cords[1]].nil?
    end
    false
  end
end
