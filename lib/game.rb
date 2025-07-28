require_relative "helper_modules/game_modules/another_game"
require_relative "helper_modules/game_modules/call_methods"
require_relative "helper_modules/game_modules/get_coordinates"
require_relative "helper_modules/game_modules/load_game"
require_relative "helper_modules/game_modules/print_information"
require_relative "helper_modules/game_modules/save_game"
require "colorize"
require "yaml"

# Contains the game and all of its methods for playing the game
class Game
  include AnotherGame
  include CallMethods
  include GetCoordinates
  include LoadGame
  include PrintInfo
  include SaveGame

  attr_accessor :board, :player1, :player2, :current_player, :invalid_moves

  def initialize(name1 = "Player1", name2 = "Player2")
    @board = Board.new
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @current_player = @player1
    @invalid_moves = 20
  end

  # Method for playing the game, handles the game loop and asks for another game
  def play_game
    board.print_board

    if game_loop == "quit"
      end_the_game
      return
    end

    sleep 2

    another_game
  end

  # The handles the user move, printing the game nicely on the screen checking for check and things that end the game
  # and it updates current player and current king.
  def game_loop
    loop do
      move = move_loop
      return "quit" if move == "quit"

      # clear_screen
      board.print_board

      break if game_over?

      check?

      add_to_prev_games
      update_current_player
    end
  end

  # Gets cords and move then checks to make sure this doesnt inflict check on the current palyer
  def move_loop
    loop do
      piece_cords, move_cords = legal_piece_move

      return "quit" if piece_cords == "quit"

      piece = board.board[piece_cords[0]][piece_cords[1]]

      allowed_move?(piece_cords, move_cords, piece.color) ? board.move(piece_cords, move_cords) : next

      break
    end
  end

  # Gets the cords then checks if the piece the player has chosen can make that move
  def legal_piece_move
    loop do
      piece_cords, move_cords, = legal_input

      return "quit" if piece_cords == "quit"

      piece = board.board[piece_cords[0]][piece_cords[1]]

      next unless valid_move?(piece, piece_cords, move_cords)

      return [piece_cords, move_cords]
    end
  end

  # Makes sure the piece can move there and the square is unnocupied
  def valid_move?(piece, piece_cords, move_cords)
    return true if piece.legal_move?(board.board, piece_cords, move_cords) &&
                   unnocupied_square?(piece, move_cords)

    false
  end

  # Deep copys the board then makes the move, then checks if that move is legal, ie not in check
  def allowed_move?(piece_cords, move_cords, color)
    future_board = board.clone_and_update(piece_cords, move_cords)

    return false if current_player.color == color && in_check?(future_board, color)

    true
  end

  # Removes the board from the screen so tons of board dont stack up over and over
  def clear_screen
    print "\e[#{@invalid_moves}A\e[J"

    @invalid_moves = 20
  end

  # This handles which color to print the board for
  def print_board_color
    return "black" if current_player.color == "white"

    "white"
  end

  # Checks if there is a reason to end the game
  def game_over?
    return true if checkmate? || stalemate? || threefold_repetition? || insufficient_material?

    false
  end

  def add_to_prev_games
    fen = board.convert_to_fen(board.board, current_player.color)
    board.previous_boards << fen
  end

  def update_current_player
    @current_player = current_player == player1 ? player2 : player1
  end
end
