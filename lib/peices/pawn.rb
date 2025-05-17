# require_relative "move_functionality"

# Contains all the methods for the pawn peice
class Pawn
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
    @board = nil
  end

  def move(board, peice, peice_cords, move_cords)
    @board = board
    if legal_move?(peice_cords, move_cords, peice) && unocupided_square?(move_cords, peice)
      @board[move_cords[0]][move_cords[1]] = peice
      @board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    @board
  end

  def legal_move?(peice_cords, move_cords, peice)
    legal_moves = possible_positions(peice, peice_cords)

    return true if legal_moves.include?([move_cords[0], move_cords[1]])

    false
  end

  def unocupided_square?(move_cords, peice)
    return true unless @board[move_cords[0]][move_cords[1]]&.color == peice.color

    false
  end

  # Returns all possible positions for pawn to go to
  def possible_positions(peice, peice_cords)
    possible_moves = []

    if peice.color == "white"
      white_forward(peice_cords).each { |cords| possible_moves << cords }
      white_take(peice_cords).each { |cords| possible_moves << cords }
    elsif peice.color == "black"
      black_forward(peice_cords).each { |cords| possible_moves << cords }
      black_take(peice_cords).each { |cords| possible_moves << cords }
    end

    possible_moves
  end

  # Forward moves method for white
  def white_forward(cords)
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x + 1, y] if (x + 1).between?(0, 7)
    possible_moves << [x + 2, y] if (x + 2).between?(0, 7) && x == 1
    possible_moves
  end

  # Forward moves method for black
  def black_forward(cords)
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x - 1, y] if (x - 1).between?(0, 7)
    possible_moves << [x - 2, y] if (x - 2).between?(0, 7) && x == 6
    possible_moves
  end

  # Taking method for white peices
  def white_take(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x + 1, y - 1] if (x + 1).between?(0, 7) && (y - 1).between?(0, 7) && @board[x + 1][y - 1]&.color == "black"
    possible_moves << [x + 1, y + 1] if (x + 1).between?(0, 7) && (y + 1).between?(0, 7) && @board[x + 1][y + 1]&.color == "black"
    possible_moves
  end

  # Taking method for black peices
  def black_take(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []
    possible_moves << [x - 1, y - 1]  if (x - 1).between?(0, 7) && (y - 1).between?(0, 7) && @board[x - 1][y - 1]&.color == "white"
    possible_moves << [x +- 1, y + 1] if (x - 1).between?(0, 7) && (y + 1).between?(0, 7) && @board[x - 1][y + 1]&.color == " white"
    possible_moves
  end
end
