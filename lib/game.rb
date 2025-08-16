require_relative "helper_modules/game_modules/another_game"
require_relative "helper_modules/game_modules/call_methods"
require_relative "helper_modules/game_modules/get_coordinates"
require_relative "helper_modules/game_modules/load_game"
require_relative "helper_modules/game_modules/game_over"
require_relative "helper_modules/game_modules/save_game"
require "colorize"
require "yaml"

# Contains the game and all of its methods for playing the game
class Game
  include AnotherGame
  include CallMethods
  include GetCoordinates
  include LoadGame
  include GameOver
  include SaveGame

  attr_accessor :board, :player1, :player2, :current_player, :lines_to_clear

  def initialize(name1 = "Player1", name2 = "Player2")
    @board = Board.new
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @current_player = @player1
    @lines_to_clear = 11
  end

  # Method for playing the game, handles the game loop and asks for another game
  def play_game
    print_board
    game_result = game_loop

    if %w[save quit draw].include?(game_result)
      save_game if game_result == "save"
      draw_game if game_result == "draw"

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
      return move if %w[save quit draw].include?(move)

      clear_screen
      print_board

      break if game_over?

      check?

      update_current_player
      update_previous_boards
    end
  end

  # Gets cords and move then checks to make sure this doesnt inflict check on the current palyer
  def move_loop
    loop do
      piece_cords, move_cords = legal_input

      return piece_cords if %w[save quit draw].include?(piece_cords)

      piece = board.board[piece_cords[0]][piece_cords[1]]

      next unless allowed_move?(piece, piece_cords, move_cords)

      move(piece, piece_cords, move_cords)

      break
    end
  end

  def allowed_move?(piece, piece_cords, move_cords)
    return true if legal_piece_move?(piece, piece_cords, move_cords) &&
                   valid_move?(piece, piece_cords, move_cords)

    false
  end

  # Makes sure the piece can move there and the square is unnocupied
  def legal_piece_move?(piece, piece_cords, move_cords)
    return true if piece.legal_move?(board.board, piece_cords, move_cords) &&
                   unnocupied_square?(piece, move_cords)

    false
  end

  # Deep copys the board then makes the move, then checks if that move is legal, ie not in check
  def valid_move?(piece, piece_cords, move_cords)
    piece_color = piece.color

    future_board = board.clone_and_update(piece_cords, move_cords)

    return true unless in_check?(future_board, piece_color)

    false
  end

  # Removes the board from the screen so tons of board dont stack up over and over
  def clear_screen
    print "\e[#{lines_to_clear}A\e[J"

    @lines_to_clear = 11
  end

  # Checks if there is a reason to end the game
  def game_over?
    return true if checkmate? || stalemate? || threefold_repetition? || insufficient_material?

    false
  end

  # Updates the current player
  def update_current_player
    @current_player = current_player == player1 ? player2 : player1
  end
end
