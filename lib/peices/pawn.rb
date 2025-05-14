require_relative "../board"
# Contains all the methods for the pawn peice
class Pawn
  attr_accessor :symbol, :peice, :color

  def initialize(symbol, color, peice)
    @symbol = symbol
    @color = color
    @peice = peice
  end

  def move(peice_cords, move_cords, board, peice)
    if legal_move?(peice_cords, move_cords)
      board[move_cords[0]][move_cords[1]] = peice
      board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    board
  end

  def legal_move?(peice_cords, move_cords)
    return true if (move_cords[0] == peice_cords[0] + 1) ||
                   move_cords[0] == peice_cords[0] + 2 && peice_cords[0] == 1

    false
  end
end
