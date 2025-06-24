require "colorize"

# Contains the game and all of its methods for playing the game
class Game # rubocop:disable Metrics/ClassLength
  attr_accessor :board, :player1, :player2, :current_player, :white_king_cords, :black_king_cords

  def initialize(name1 = "Jim", name2 = "John")
    @board = Board.new
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @current_player = @player1
    @white_king_cords = [0, 4]
    @black_king_cords = [7, 4]
  end

  # Method for playing the game, handles the game loop and asks for another game
  def play_game
    board.print_board

    game_loop

    # Ask for another game
  end

  # The handles the user move, updating the current player, check and checkmate
  def game_loop
    loop do
      move_loop

      board.print_board

      break if checkmate?(white_king_cords, "white")

      check(white_king_cords, "white")

      break if checkmate?(black_king_cords, "black")

      check(black_king_cords, "black")

      puts ""
      update_turn
    end
  end

  # This repeates until player enters a legal move
  def move_loop # rubocop:disable Metrics/AbcSize,Metrics/MethodLength"
    loop do
      piece_cords, move_cords, _invalid_moves = legal_input

      piece = board.board[piece_cords[0]][piece_cords[1]]

      if piece&.name == "king"
        castling if move_cords[0]
        # castling
        # update king position
        # break loop
      end

      next unless piece.legal_move?(board.board, piece_cords, move_cords) && unnocupied_square?(piece, move_cords)

      update_king_position(piece, move_cords) if piece&.name == "king"

      board.move(piece_cords, move_cords)

      if invalid_move?(white_king_cords, "white") || invalid_move?(black_king_cords, "black")
        board.reverse_move(piece_cords, move_cords)
        next
      end

      board.promotion(piece.color, move_cords) if piece&.name == "pawn"

      p board.board[move_cords[0]][move_cords[1]]
      break
    end
  end

  # This repeats until a players cords are valid then turns them into usable cords
  def legal_input
    invalid_moves = 22
    cords = []

    loop do
      cords = take_input
      invalid_moves += 3

      next unless legal_move?(cords[0]) && legal_move?(cords[1])

      cords.map! { |position| to_cords(position) }

      break if correct_color?(cords[0])
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

    [piece_cords, move_cords]
  end

  # Makes sure both cords are valid and have a length of 2
  def legal_move?(cords)
    letter = cords[0]
    number = cords[1].to_i - 1

    return true if letter.between?("a", "h") && number.between?(0, 7) && cords.length == 2

    false
  end

  # Turns coordinates like [a, 1] into [0, 0]
  def to_cords(cords)
    alphabet = ("a".."h").to_a

    [cords[1].to_i - 1, alphabet.find_index(cords[0])]
  end

  # Checks to make sure the player is choosing their color pieces only
  def correct_color?(piece_cords)
    return true if board.board[piece_cords[0]][piece_cords[1]]&.color == current_player.color

    false
  end

  # Updates turn from player 1 to player 2
  def update_turn
    @current_player = current_player == player1 ? player2 : player1
  end

  # Checks if the player is allowed to make that move, depends on if there in check and its there go
  def invalid_move?(king_cords, color)
    return true if current_player.color == color && in_check?(king_cords, color)

    false
  end

  # Checks to make sure the place the player would like to move their piece is empty
  def unnocupied_square?(piece, move_cords)
    board.unnocupied_square?(piece, move_cords)
  end

  def check(king_cords, color)
    puts "#{color.capitalize} is in check".colorize(:red) if in_check?(king_cords, color)
  end

  def checkmate?(king_cords, color)
    return unless in_check?(king_cords, color) && in_checkmate?(king_cords, color)

    puts "#{color.capitalize} is in checkmate".colorize(:red)

    true
  end

  # Updates king cords when king is moved
  def update_king_position(piece, move_cords)
    @white_king_cords = move_cords if piece.color == "white"

    @black_king_cords = move_cords if piece.color == "black"
  end

  # Checks if the player is in check
  def in_check?(cords, color)
    board.in_check?(cords, color)
  end

  # Checks if the player is in checkmate
  def in_checkmate?(king_cords, color)
    # false
    board.checkmate?(king_cords, color)
  end

  # print "\e[#{coordinates[2]}A\e[J" # Will be used later for printing nicely
end

# update
