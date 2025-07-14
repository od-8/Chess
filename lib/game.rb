require "colorize"
require_relative "helper_methods/game_helper_modules/print_information"
require_relative "helper_methods/game_helper_modules/update_cords"
require_relative "helper_methods/game_helper_modules/get_coordinates"
require_relative "helper_methods/game_helper_modules/call_methods"

# Contains the game and all of its methods for playing the game
class Game
  include PrintInfo
  include UpdateCords
  include GetCoordinates
  include CallMethods

  attr_accessor :board, :player1, :player2, :current_player, :white_king_cords, :black_king_cords, :current_king,
                :invalid_moves

  def initialize(name1 = "Jim", name2 = "John")
    @board = Board.new
    @player1 = Player.new(name1, "white")
    @player2 = Player.new(name2, "black")
    @current_player = @player1
    @white_king_cords = [0, 4]
    @black_king_cords = [7, 4]
    @current_king = [[0, 4], "white"]
    @invalid_moves = 20
  end

  # Method for playing the game, handles the game loop and asks for another game
  def play_game
    board.print_board # ("white")

    game_loop
    sleep 1

    another_game
  end

  # The handles the user move, printing the game nicely on the screen checking for check and things that end the game 
  # and it updates current player and current king.
  def game_loop
    loop do
      move_loop
      # clear_screen

      board.print_board # (print_board_color)

      break if checkmate? || stalemate? || insufficient_material? || threefold_repetition?

      check?

      update_current_player
      update_current_king
    end
  end

  # Gets cords and move then checks to make sure this doesnt inflict check on the current palyer
  def move_loop
    loop do
      piece_cords, move_cords = legal_piece_move

      piece = board.board[piece_cords[0]][piece_cords[1]]

      king_cords = handle_king_cords(piece, move_cords)

      allowed_move?(piece_cords, move_cords, king_cords, current_king[1]) ? board.move(piece_cords, move_cords) : next

      update_king_cords(piece, move_cords)
      break
    end
  end

  # Gets the cords then checks if the piece the player has chosen can make that move
  def legal_piece_move
    loop do
      piece_cords, move_cords, _invalid_moves = legal_input

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
  def allowed_move?(piece_cords, move_cords, king_cords, color)
    future_board = board.clone_and_update(piece_cords, move_cords)

    return false if current_player.color == color && in_check?(future_board, king_cords, color)

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

  # Based on player inputs it either starts a new game or says thank you message
  def another_game
    answer = another_game_answer
    if answer == "yes"
      @invalid_moves = 26
      clear_screen
      new_game = Game.new(@player1.name, @player2.name)
      new_game.play_game
    else
      puts "Thank you for playing chess.".colorize(:green)
      puts ""
    end
  end

  # Asks if players would like to play another game
  def another_game_answer
    loop do
      puts "Enter yes if you would like to play another game or no if you want to quit"
      puts ""
      print "Your descision: "
      answer = gets.chomp.downcase
      puts ""

      return answer if %w[yes no].include?(answer)
    end
  end
end
