# Contains the game and all of its methods for playing the game
class Game
  attr_accessor :board, :player1, :player2, :current_player

  def initialize(name1 = "Jim", name2 = "John")
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @board = Board.new
    @current_player = @player1
    @white_king_cords = [0, 3]
    @black_king_cords = [7, 3]
  end

  # The method for actually playing the game
  def play_game
    board.print_board

    game_loop
  end

  # This repeates until someone wins
  def game_loop # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    loop do
      piece_cords, move_cords, _invalid_moves = legal_input
      piece = board.board[piece_cords[0]][piece_cords[1]]

      next unless piece.legal_move?(board.board, piece_cords, move_cords) && unnocupied_square?(piece, move_cords)

      board.update_king_position(piece, move_cords) if piece&.name == "king"

      p board.when_check(board.board, piece_cords, "white") if in_check?(@white_king_cords, "white")
      p board.when_check(board.board, piece_cords, "black") if in_check?(@black_king_cords, "black")

      board.move(piece_cords, move_cords)

      board.print_board
      update_turn
    end
  end

  # Checks if the input is valid then turns it into actual coordiantes
  def legal_input
    invalid_moves = 22
    cords = []

    loop do
      cords = take_input
      invalid_moves += 3

      next unless legal_move?(cords[0]) && legal_move?(cords[1])

      cords.map! { |position| to_cords(position) }

      break if correct_color?(cords[0], current_player.color)
    end
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

  # Makes sure both cords are valid and are at 2 long
  def legal_move?(cords)
    letter = cords[0]
    number = cords[1].to_i - 1

    return true if letter.between?("a", "h") && number.between?(0, 7) && cords.length == 2

    false
  end

  def correct_color?(cords, color)
    board.same_color?(cords, color)
  end

  def unnocupied_square?(piece, move_cords)
    board.unnocupied_square?(piece, move_cords)
  end

  def in_check?(cords, color)
    board.in_check?(cords, color)
  end

  def checkmate?
    board.checkmate?
  end

  # print "\e[#{coordinates[2]}A\e[J" # Will be used later for printing nicely
end

# Check if king is in check pre move
#  - if true list all possible moves for king and peices that can block
#  - if false carry on as usual

# Check if king is in check post move
#  - if true reverse move and get them to take go again
#  - if false carry on as usual
