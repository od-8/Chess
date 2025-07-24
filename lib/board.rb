# Helper stuff
require_relative "helper_modules/board_modules/add_pieces_to_board"
require_relative "helper_modules/board_modules/castling"
require_relative "helper_modules/board_modules/check"
require_relative "helper_modules/board_modules/checkmate"
require_relative "helper_modules/board_modules/convert_from_fen"
require_relative "helper_modules/board_modules/convert_to_fen"
require_relative "helper_modules/board_modules/en_passant"
require_relative "helper_modules/board_modules/insufficient_material"
require_relative "helper_modules/board_modules/promotion"
require_relative "helper_modules/board_modules/threefold_repetition"

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
  include AddPieces
  include Castling
  include Check
  include Checkmate
  include ConvertFromFen
  include ConvertToFen
  include EnPassant
  include InsufficientMaterial
  include Promotion
  include ThreefoldRepetition

  attr_accessor :board, :previous_boards, :passantable_pawn_cords

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @passantable_pawn_cords = nil
    @previous_boards = []
    add_peices
  end

  # Prints the board like a chess board
  def print_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts ""
    puts "+---+---+---+---+---+---+---+---+".center(54)
    board.each_with_index do |row, index|
      print " ".center(8)
      print "#{8 - index} |"
      row.each do |piece|
        print piece.nil? ? "   |" : " #{piece&.symbol} |"
      end
      puts ""
      puts "+---+---+---+---+---+---+---+---+".center(54)
    end
    puts "a   b   c   d   e   f   g   h".center(54)
    puts ""
  end

  # Does stuff for before a move like when castling it handles moving the rook, handles promotion and en passant
  def move(piece_cords, move_cords)
    piece = board[piece_cords[0]][piece_cords[1]]

    piece = handle_piece(piece, piece_cords, move_cords)

    move_piece(piece, piece_cords, move_cords)
  end

  def handle_piece(piece, piece_cords, move_cords)
    return piece if %w[bishop kngiht].include?(piece.name)

    handle_rook(piece)
    handle_king(piece, piece_cords, move_cords)
    handle_pawn(piece, piece_cords, move_cords)
  end

  def handle_pawn(piece, piece_cords, move_cords)
    return piece unless piece.name == "pawn"

    update_passantable_status(piece, piece_cords, move_cords)
    remove_passant_pawn(piece, piece_cords, move_cords)

    promotion(piece, move_cords)
  end

  def handle_rook(piece)
    return unless piece.name == "rook"

    piece.update_move_status
  end

  def handle_king(piece, piece_cords, move_cords)
    return unless piece.name == "king"

    castling(piece_cords, move_cords)
    piece.update_move_status
  end

  # Moves piece from where it currently is (piece_cords) to where it wants to go (move_cords)
  def move_piece(piece, piece_cords, move_cords)
    @board[move_cords[0]][move_cords[1]] = piece
    @board[piece_cords[0]][piece_cords[1]] = nil

    update_previous_boards
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

  # Adds the board to previous board, used for threefold repetition
  def update_previous_boards
    fen_str = convert_to_fen(board)
    @previous_boards << fen_str
  end
end
