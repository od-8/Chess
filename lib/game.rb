require "colorize"
require_relative "helper_methods/game_helper_modules/get_coordinates"
require_relative "helper_methods/game_helper_modules/call_methods"

# Contains the game and all of its methods for playing the game
class Game
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
  end

  # Method for playing the game, handles the game loop and asks for another game
  def play_game
    board.print_board

    game_loop

    # Ask for another game
  end

  # The handles the user move, updating the current player, check and checkmate
  def game_loop # rubocop:disable Metrics/AbcSize
    loop do
      move_loop
      board.print_board

      break if checkmate?(white_king_cords, "white") || stalemate?(white_king_cords, "white") || not_enough_pieces || draw_by_repetition

      check(white_king_cords, "white")

      break if checkmate?(black_king_cords, "black") || stalemate?(black_king_cords, "black")

      check(black_king_cords, "black")

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

  # Print statement for when either king is in checkmate
  def check(king_cords, color)
    return unless in_check?(board.board, king_cords, color)

    puts "#{color.capitalize} king is in check".colorize(:green)
    puts ""
  end

  # Print statement for when either king is in checkmate
  def checkmate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) && in_checkmate?(king_cords, color)

    puts "#{color.capitalize} king is in checkmate".colorize(:red)
    puts ""

    true
  end

  def stalemate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) == false &&
                  in_checkmate?(king_cords, color) &&
                  current_player.color != color

    puts "Stalemate. There are no winners.".colorize(:red)
    puts ""

    true
  end

  def not_enough_pieces
    return unless insufficient_material?

    puts "Insufficient material. There are no winners.".colorize(:red)
    puts ""

    true
  end

  def draw_by_repetition
    return unless threefold_repetition?

    puts "Threefold repetition. There are no winners.".colorize(:red)
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
    @current_king = [white_king_cords, "white"] if current_player.color == "black"

    @current_king = [black_king_cords, "black"] if current_player.color == "white"
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

  # print "\e[#{coordinates[2]}A\e[J" # Will be used later for printing nicely
end
