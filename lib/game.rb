require "colorize"
require_relative "helper_methods/game_helper_modules/get_coordinates"
require_relative "helper_methods/game_helper_modules/call_methods"

# Contains the game and all of its methods for playing the game
class Game # rubocop:disable Metrics/ClassLength
  include GetCoordinates
  include CallMethods

  attr_accessor :board, :player1, :player2, :current_player, :white_king_cords, :black_king_cords, :current_king

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
    board.print_board("white")

    game_loop

    # Ask for another game
  end

  # The handles the user move, updating the current player, check and checkmate
  def game_loop
    loop do
      move_loop
      clear_screen

      board.print_board(current_player.color)

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

  # Updates turn from player 1 to player 2
  def update_current_player
    @current_player = current_player == player1 ? player2 : player1
  end

  def check?
    return true if print_check?(white_king_cords, "white") || print_check?(black_king_cords, "black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_check?(king_cords, color)
    return unless in_check?(board.board, king_cords, color)

    @invalid_moves += 2
    puts "#{color.capitalize} king is in check".colorize(:green)
    puts ""
  end

  def checkmate?
    return true if print_checkmate?(white_king_cords, "white") || print_checkmate?(black_king_cords, "black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_checkmate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) && in_checkmate?(king_cords, color)

    puts "#{color.capitalize} king is in checkmate".colorize(:red)
    puts ""

    true
  end

  def stalemate?
    return true if print_stalemate?(white_king_cords, "white") || print_stalemate?(black_king_cords, "black")

    false
  end

  def print_stalemate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) == false &&
                  in_checkmate?(king_cords, color) &&
                  current_player.color != color

    puts "It is #{color}'s go and they cant make any legal moves. Stalemate".colorize(:red)
    puts ""

    true
  end

  def insufficient_material?
    return unless checkmate_isnt_possible?

    puts "Insufficinet material. Draw".colorize(:red)
    puts ""

    true
  end

  def threefold_repetition?
    return unless draw_by_repetition?

    puts "Threefold repetition. Draw".colorize(:red)
    puts ""

    true
  end

  # This handles an issue when preforming an invalid move with the king then moving any other piece including the king
  # The king cords would be updated but then wouldnt be reset resulting in the game thinking the king is in the invalid
  # square. This method returns the move cords if the piece being moved is the king, or the current kings cords if the
  # piece being moved is not a king
  def handle_king_cords(piece, move_cords)
    return move_cords if piece.name == "king"

    current_king[0]
  end

  # The current king is the king corresponding to the current player
  # If the current player has the white pieces then the current king is the white king
  def update_current_king
    @current_king = if @current_king == [white_king_cords, "white"]
                      [black_king_cords, "black"]
                    else
                      [white_king_cords, "white"]
                    end
  end

  # Updated the coordinates of the king
  def update_king_cords(piece, move_cords)
    return unless piece.name == "king"

    piece.color == "white" ? @white_king_cords = move_cords : @black_king_cords = move_cords

    piece.king_moved = true
  end

  # Deep copys the board then makes the move, then checks wether that move is legal, ie not in check
  def allowed_move?(piece_cords, move_cords, king_cords, color)
    future_board = board.clone_and_update(piece_cords, move_cords)

    return false if current_player.color == color && in_check?(future_board, king_cords, color)

    true
  end

  def clear_screen
    print "\e[#{@invalid_moves}A\e[J"

    @invalid_moves = 20
  end

  # print "\e[#{coordinates[2]}A\e[J" # Will be used later for printing nicely
end
