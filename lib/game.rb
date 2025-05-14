# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2

  def initialize(name1 = "player1", name2 = "player2")
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @board = Board.new
  end

  def take_a_go
    3.times do
    board.print_board
    print "Input position of the peice you want to move: ".colorize(:red)
    peice_position = gets.chomp.downcase
    puts ""
    print "Input position you would like to move this peice: "
    move_position = gets.chomp.downcase
    peice_cords = to_coordinate(peice_position)
    move_cords = to_coordinate(move_position)

    board.move(peice_cords, move_cords)
    end
  end

  def to_coordinate(cords)
    alphabet = ("a".."z").to_a

    [cords[1].to_i - 1, alphabet.find_index(cords[0])]
  end
end
