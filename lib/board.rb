require_relative "peices/king"
require_relative "peices/queen"
require_relative "peices/rook"
require_relative "peices/bishop"
require_relative "peices/knight"
require_relative "peices/pawn"

# Contains the board and all of its methods
class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup
  end

  def print_board # rubocop:disable Metrics/MethodLength
    puts ""
    # @board.each do |row|
    puts "+---+---+---+---+---+---+---+---+"
    @board.reverse.each do |row|
      row.each do |peice|
        print "| #{peice.peice} " unless peice.nil?
        print "|   " if peice.nil?
      end
      print "|"
      puts ""
      puts "+---+---+---+---+---+---+---+---+"
    end
    puts ""
  end

  def setup
    king_setup
    queen_setup
    rook_setup
    bishop_setup
    knight_setup
    pawn_setup
  end

  def king_setup
    @board[0][3] = King.new("k1", "white", "\u265a")
    @board[7][3] = King.new("k1", "black", "\u2654")
  end

  def queen_setup
    @board[0][4] = Queen.new("q1", "white", "\u265b")
    @board[7][4] = Queen.new("q1", "black", "\u2655")
  end

  def rook_setup
    @board[0][0] = Rook.new("r1", "white", "\u265c")
    @board[0][7] = Rook.new("r2", "white", "\u265c")
    @board[7][0] = Rook.new("r1", "black", "\u2656")
    @board[7][7] = Rook.new("r2", "black", "\u2656")
  end

  def bishop_setup
    @board[0][2] = Bishop.new("b1", "white", "\u265d")
    @board[0][5] = Bishop.new("b2", "white", "\u265d")
    @board[7][2] = Bishop.new("b1", "black", "\u2657")
    @board[7][5] = Bishop.new("b2", "black", "\u2657")
  end

  def knight_setup
    @board[0][1] = Knight.new("k1", "white", "\u265e")
    @board[0][6] = Knight.new("k1", "white", "\u265e")
    @board[7][1] = Knight.new("k1", "white", "\u2658")
    @board[7][6] = Knight.new("k1", "white", "\u2658")
  end

  def pawn_setup # rubocop:disable Metrics/AbcSize
    @board[1].each_with_index do |_peice, index|
      @board[1][index] = Pawn.new("p#{index}", "white", "\u265f")
      @board[6][index] = Pawn.new("p#{index}", "black", "\u2659")
    end

    @board[2].each_with_index do |_peice, index|
      @board[1][index] = Pawn.new("p#{index}", "white", "\u265f")
      @board[6][index] = Pawn.new("p#{index}", "black", "\u2659")
    end
  end
end
