# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2

  def initialize(name1 = "player1", name2 = "player2")
    @player1 = name1
    @player2 = name2
    @board = Board.new
  end
end
