require "colorize"
require_relative "helper_methods/game_helper_modules/get_coordinates"
require_relative "helper_methods/game_helper_modules/call_board_methods"

# Contains the game and all of its methods for playing the game
class Game
  include GetCoordinates
  include BoardMethods

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
  def move_loop # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    loop do
      piece_cords, move_cords = sub_move

      piece = possible_promotion(board.board[piece_cords[0]][piece_cords[1]], piece_cords, move_cords[0])

      king_cords = handle_king_cords(piece, move_cords)

      board.move(piece_cords, move_cords)

      if invalid_move?(king_cords, current_king[1])
        board.reverse_move(piece_cords, move_cords)
        next
      end

      update_king_cords(piece, move_cords)
      update_king(piece)
      break
    end
  end

  def sub_move
    loop do
      piece_cords, move_cords, _invalid_moves = legal_input

      piece = board.board[piece_cords[0]][piece_cords[1]]

      next unless valid_move?(piece, piece_cords, move_cords)

      return [piece_cords, move_cords]
    end
  end

  def valid_move?(piece, piece_cords, move_cords)
    return true if piece.legal_move?(board.board, piece_cords, move_cords) &&
                   unnocupied_square?(piece, move_cords)

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

  def check(king_cords, color)
    puts "#{color.capitalize} is in check".colorize(:red) if in_check?(king_cords, color)
  end

  def checkmate?(king_cords, color)
    return unless in_check?(king_cords, color) && in_checkmate?(king_cords, color)

    puts "#{color.capitalize} is in checkmate".colorize(:red)

    true
  end

  # This method basically handles when the king is moved, that kings cords are not updated so it might
  def handle_king_cords(piece, move_cords)
    return move_cords if piece.name == "king"

    current_king[0]
  end

  def possible_promotion(piece, piece_cords, row)
    piece = piece.promote if piece.name == "pawn" && piece.legal_promotion?(row)

    board.board[piece_cords[0]][piece_cords[1]] = piece

    piece
  end

  def update_king(piece)
    @current_king = [white_king_cords, "white"] if piece.color == "black"

    @current_king = [black_king_cords, "black"] if piece.color == "white"
  end

  def update_king_cords(piece, move_cords)
    return unless piece.name == "king"

    if piece.color == "white"
      board.white_king_moved = true
      @white_king_cords = move_cords
    end

    return unless piece.color == "black"

    board.black_king_moved = true if piece.name == "king"
    @black_king_cords = move_cords
  end

  # print "\e[#{coordinates[2]}A\e[J" # Will be used later for printing nicely
end

# update
