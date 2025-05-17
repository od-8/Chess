# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2

  def initialize(name1 = "player1", name2 = "player2")
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @board = Board.new
  end

  # The method for actually playing the game
  def play_game
    board.print_board

    game_loop
  end

  # This repeates until someone wins
  def game_loop
    until game_over?
      coordinates = player_turn

      board.move(coordinates[0], coordinates[1])
      # print "\e[22A\e[J"
      board.print_board
    end
  end

  # This method turns the user input into usable coordiantes and checks if they're valid
  def player_turn
    coordinates = []

    loop do
      positions = take_input
      coordinates = [to_coordinate(positions[0]), to_coordinate(positions[1])]

      break if valid_move?(coordinates[0]) && valid_move?(coordinates[1])

      puts "Input error"
      puts ""
    end

    coordinates
  end

  def take_input
    print "Input position of the peice you would like to move: "
    peice_position = gets.chomp.downcase
    puts ""
    print "Input position of where you would like to move that peice: "
    move_position = gets.chomp.downcase

    [peice_position, move_position]
  end

  def to_coordinate(cords)
    alphabet = ("a".."z").to_a

    [cords[1].to_i - 1, alphabet.find_index(cords[0])]
  end

  def valid_move?(cords)
    board.valid_move?(cords)
  end

  def game_over?
    board.game_over?
  end
end
