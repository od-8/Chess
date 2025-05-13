# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2

  def initialize(name1 = "player1", name2 = "player2")
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @board = Board.new
  end

  def take_a_go
    puts "Input position"
    input = gets.chomp.downcase

    board.move(to_coordinate(input[0]), input[1].to_i - 1)
  end

  def to_coordinate(letter)
    alphabet = ("a".."z").to_a

    alphabet.find_index(letter)
  end
end
