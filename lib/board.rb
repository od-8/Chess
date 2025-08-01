# Helper stuff
require_relative "helper_modules/board_modules/castling"
require_relative "helper_modules/board_modules/check"
require_relative "helper_modules/board_modules/checkmate"
require_relative "helper_modules/board_modules/convert_from_fen"
require_relative "helper_modules/board_modules/convert_to_fen"
require_relative "helper_modules/board_modules/en_passant"
require_relative "helper_modules/board_modules/insufficient_material"
require_relative "helper_modules/board_modules/promotion"
require_relative "helper_modules/board_modules/threefold_repetition"
require_relative "helper_modules/board_modules/fifty_move_rule"
require_relative "helper_modules/board_modules/load_prev_game"

# Peices
require_relative "pieces/bishop"
require_relative "pieces/black_pawn"
require_relative "pieces/king"
require_relative "pieces/knight"
require_relative "pieces/queen"
require_relative "pieces/rook"
require_relative "pieces/white_pawn"

# Contains the board and all of its methods
class Board
  include Castling
  include Check
  include Checkmate
  include ConvertFromFen
  include ConvertToFen
  include EnPassant
  include InsufficientMaterial
  include Promotion
  include ThreefoldRepetition
  include FiftyMoveRule
  include LoadPreviousGame

  attr_accessor :board, :previous_boards, :passantable_pawn_cords, :half_moves, :full_moves

  def initialize(board = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
    @board = convert_board_from_fen(board)
    @passantable_pawn_cords = nil
    @previous_boards = ["rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq 0 0"]
    @half_moves = 0
    @full_moves = 0
  end

  # Prints the board like a chess board
  def print_board # rubocop:disable Metrics/MethodLength
    i = 0
    puts ""
    board.each_with_index do |row, index|
      print " #{(8 - index).to_s.colorize(:yellow)} "
      row.each_with_index do |piece, _piece_index|
        print print_piece(piece, i)

        i += 1
      end

      i += 1
      puts ""
    end
    puts "    a  b  c  d  e  f  g  h".colorize(:yellow)
    puts ""
  end

  def print_piece(piece, square)
    if piece.nil?
      square.even? ? "\e[48;2;106;106;106m   \e[0m" : "\e[48;2;55;55;55m   \e[0m"
    else
      square.even? ? "\e[48;2;106;106;106m #{piece&.symbol} \e[0m" : "\e[48;2;55;55;55m #{piece&.symbol} \e[0m"
    end
  end

  # Does stuff for before a move like when castling it handles moving the rook, handles promotion and en passant
  def move(piece, piece_cords, move_cords)
    piece = handle_piece(piece, piece_cords, move_cords)

    update_move_counters(piece, move_cords)
    move_piece(piece, piece_cords, move_cords)
  end

  # Moves piece from where it currently is (piece_cords) to where it wants to go (move_cords)
  def move_piece(piece, piece_cords, move_cords)
    @board[move_cords[0]][move_cords[1]] = piece
    @board[piece_cords[0]][piece_cords[1]] = nil
  end

  # Handles pieces differently depending on what piece is being moved
  def handle_piece(piece, piece_cords, move_cords)
    return piece if %w[queen bishop kngiht].include?(piece.name)

    handle_rook(piece)
    handle_king(piece, piece_cords, move_cords)
    handle_pawn(piece, piece_cords, move_cords)
  end

  # Updates passantable status and if pawn is promoting
  def handle_pawn(piece, piece_cords, move_cords)
    return piece unless piece.name == "pawn"

    update_passantable_status(piece, piece_cords, move_cords)
    remove_passant_pawn(piece, piece_cords, move_cords)

    promotion(piece, move_cords)
  end

  # Updates the rooks moved status
  def handle_rook(piece)
    return unless piece.name == "rook"

    piece.update_move_status
  end

  # Updates the kings moved status and handles castling
  def handle_king(piece, piece_cords, move_cords)
    return unless piece.name == "king"

    castling(piece_cords, move_cords)
    piece.update_move_status
  end

  # Checks if the square is occupied by a piece with the same color
  def unnocupied_square?(piece, move_cords)
    return true unless board[move_cords[0]][move_cords[1]]&.color == piece.color

    false
  end

  # Deep copys the board then makes the move
  # Used to check future state of board and if a move is valid, like you cant make a move that puts you in check
  def clone_and_update(piece_cords, move_cords)
    clone_board = Marshal.load(Marshal.dump(board))
    piece = clone_board[piece_cords[0]][piece_cords[1]]

    clone_board[move_cords[0]][move_cords[1]] = piece

    clone_board[piece_cords[0]][piece_cords[1]] = nil

    clone_board
  end

  def find_king_coordinates(board, color)
    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        return [row_index, piece_index] if piece&.name == "king" && piece&.color == color
      end
    end
  end

  def update_previous_boards(color)
    fen_board = convert_to_fen(board, color)
    @previous_boards << fen_board
  end
end
