require_relative "../board"
# Contains all the methods for the pawn peice
class Pawn
  attr_accessor :symbol, :peice, :color

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end

  def move(row, column, peice, board)
    board[column + 1][row] = peice
    # p board[column][row + 1]
    board[column][row] = nil
    board
  end
end
