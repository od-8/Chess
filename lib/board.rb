# Helper stuff
require_relative "helper_methods/board_helper_methods/print_color_board"
require_relative "helper_methods/board_helper_methods/add_pieces_to_board"
require_relative "helper_methods/board_helper_methods/en_passant"
require_relative "helper_methods/board_helper_methods/castling"
require_relative "helper_methods/board_helper_methods/promotion"
require_relative "helper_methods/board_helper_methods/check"
require_relative "helper_methods/board_helper_methods/checkmate"
require_relative "helper_methods/board_helper_methods/insufficient_material"
require_relative "helper_methods/board_helper_methods/threefold_repetition"
require_relative "helper_methods/board_helper_methods/convert_to_fen"
require_relative "helper_methods/board_helper_methods/convert_from_fen"

# Peices
require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/white_pawn"
require_relative "peices/black_pawn"

# Contains the board and all of its methods
class Board
  # include PrintColorBoard
  include ConvertToFen
  include ConvertFromFen
  include AddPieces
  include EnPassant
  include Castling
  include Promotion
  include Check
  include Checkmate
  include InsufficientMaterial
  include ThreefoldRepetition

  attr_accessor :board, :previous_boards, :passantable_pawn

  def initialize(board = Array.new(8) { Array.new(8) })
    @board = board
    @passantable_pawn = []
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
    update_passantable_pawn
    piece = board[piece_cords[0]][piece_cords[1]]

    piece = handle_pawn(piece, piece_cords, move_cords) if piece.name == "pawn"

    castling(piece_cords, move_cords) if piece.name == "king"

    move_piece(piece, piece_cords, move_cords)
  end

  def handle_pawn(piece, piece_cords, move_cords)
    en_passant(piece, piece_cords, move_cords)
    remove_passant_pawn(piece, piece_cords, move_cords)
    promotion(piece, move_cords)
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
