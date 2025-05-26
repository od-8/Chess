# Contains all the peices for the rook peice
class King
  attr_accessor :peice, :color

  def initialize(peice, color)
    @peice = peice
    @color = color
    @board = nil
  end

  def move(board, peice, peice_cords, move_cords)
    @board = board
    if legal_move?(peice_cords, move_cords) && unocupided_square?(move_cords, peice)
      @board[move_cords[0]][move_cords[1]] = peice
      @board[peice_cords[0]][peice_cords[1]] = nil
    else
      puts "Invalid move"
    end
    @board
  end

  def possible_positions(cords) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    x = cords[0]
    y = cords[1]
    possible_moves = []

    # All possible moves for king forward
    possible_moves << [x + 1, y] if (x + 1).between?(0, 7)
    possible_moves << [x + 1, y - 1] if (x + 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x + 1, y + 1] if (x + 1).between?(0, 7) && (y + 1).between?(0, 7)

    # All possible moves for king sideways
    possible_moves << [x, y - 1] if (y - 1).between?(0, 7)
    possible_moves << [x, y + 1] if (y + 1).between?(0, 7)

    # All possible moves for king backwards
    possible_moves << [x - 1, y] if (x - 1).between?(0, 7)
    possible_moves << [x - 1, y - 1] if (x - 1).between?(0, 7) && (y - 1).between?(0, 7)
    possible_moves << [x - 1, y + 1] if (x - 1).between?(0, 7) && (y + 1).between?(0, 7)

    possible_moves
  end

  def in_check_positions?(cords)
    true if knight_check?(cords)
  end

  def pawn_check
    # do later
  end

  def knight_check?(peice_cords)
    positions = knight_possible_positions(peice_cords)
    p positions

    positions.each do |cords|
      # if @board[peice_cords[0]][peice_cords[1]]&.color == "white"
      #   puts "reaches 1"
      #   return true if @board[cords[0]][cords[1]]&.peice == "\u2658"
      # end
      return true if @board[cords[0]][cords[1]]&.peice == "\u2658"

      if @board[peice_cords[0]][peice_cords[1]]&.color == "black"
        return true if @board[cords[0]][cords[1]]&.peice == "\u265e"
      end
    end
    puts "reachs 2"
    false
  end

  def bishop_check?
    
  end

  def rook_check?
    
  end
end
