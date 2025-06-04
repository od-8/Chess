# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2, :current_player

  def initialize(name1 = "Jim", name2 = "John")
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @board = Board.new
    @current_player = @player1
  end

  # The method for actually playing the game
  def play_game
    board.print_board

    game_loop
  end

  # This repeates until someone wins
  def game_loop
    loop do
      coordinates = legal_inputs

      next unless board.same_color?(coordinates[0], current_player.color)

      board.move(coordinates[0], coordinates[1])
      print "\e[#{coordinates[2]}A\e[J"  # Will be used later for printing nicely
      board.print_board
      update_turn
    end
  end

  # Checks if the input is valid then turns it into actual coordiantes
  def legal_inputs # rubocop:disable Metrics/MethodLength
    invalid_moves = 22
    cords = []
    
    loop do
      cords = take_input
      invalid_moves += 3

      break if legal_move?(cords[0]) && legal_move?(cords[1])
    end

    cords.map! { |position| to_cords(position)}
    cords << invalid_moves
  end

  # Gets the peice the user would like to move and where they would like to move it
  def take_input
    print " #{current_player.name}, input position of the peice you would like to move: "
    piece_cords = gets.chomp.downcase
    print " #{current_player.name}, input position of where you would like to move that peice: "
    move_cords = gets.chomp.downcase
    puts ""
    
    [piece_cords, move_cords] # Coordiantes of the peice the player is moving and where they are moving it to
  end

  # Updates turn from player 1 to player 2
  def update_turn
    @current_player = current_player == player1 ? player2 : player1
  end

  # Turns coordinates like [a, 1] into [0, 0]
  def to_cords(cords)
    alphabet = ("a".."h").to_a

    [cords[1].to_i - 1, alphabet.find_index(cords[0])]
  end

  # Makes sure both cords are between 0 and 7 and the length of the cords is 2
  def legal_move?(cords)
    letter = cords[0]
    number = cords[1].to_i - 1

    return true if letter.between?("a", "h") && number.between?(0, 7) && cords.length == 2

    false
  end

  def checkmate?
    board.checkmate?
  end
end
