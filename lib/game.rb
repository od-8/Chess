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
    @white_king_cords = [7, 4]
    @black_king_cords = [0, 4]
    @current_king = [[7, 4], "white"]
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
      # clear_screen
      return "quit" if move == "quit"

      board.print_board

      break if game_over?

      check?

      update_current_player
      update_current_king
    end
  end

  # Gets cords and move then checks to make sure this doesnt inflict check on the current palyer
  def move_loop
    loop do
      piece_cords, move_cords = legal_piece_move

      return "quit" if piece_cords == "quit"

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
    if another_game?
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
  def another_game?
    loop do
      puts "Enter yes if you would like to play another game or no if you want to quit"
      puts ""
      print "Your descision: "
      answer = gets.chomp.downcase
      puts ""

      return true if %w[yes no].include?(answer)
    end

    false
  end

  def game_over?
    return true if checkmate? || stalemate? || threefold_repetition? || insufficient_material?

    false
  end

  def end_the_game
    choice = end_game_choice
    return "quit" if choice == "quit"

    acquire_new_file_name
    # save_game_information
  end

  def end_game_choice
    loop do
      puts ""
      puts "Would you like to save and quit or quit without saving"
      print "Enter #{'save'.colorize(:green)} to save and quit or #{'quit'.colorize(:green)} to quit without saving: "
      choice = gets.chomp.downcase
      puts ""
      return choice if %w[save quit].include?(choice)

      puts "Enter a valid answer"
      puts ""
    end
  end

  def acquire_new_file_name
    loop do
      puts "The game is being saved, please enter the name of the file you would like to save this game as: "
      print "Without file extension (do not include .example in the name): "
      file_name = gets.chomp.downcase
      puts ""
      break unless file_name.include?(".")

      puts "Your file cannot have dots (.) in it"
      puts ""
    end
  end

  def something # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    board_info = {
      fen_board: board.convert_to_fen(board.board),
      previous_boards: board.previous_boards
    }

    game_info = {
      current_player_name: current_player.name,
      current_player_color: current_player.color,
      white_king_cords: white_king_cords,
      black_king_cords: black_king_cords,
      current_king_cords: current_king[0],
      current_king_color: current_king[1],
      invalid_moves: invalid_moves
    }

    player_info = {
      player1_name: player1.name,
      player1_color: player1.color,
      player2_name: player2.name,
      player2_color: player2.color
    }
  end
end
