# This print the board differently depending on color.
# When its whites go then white is at the bottom, when its blacks go black is at the bottom.
# Im not sure I like this, I maybe going to use this.
module PrintColorBoard
  # Calls different print board methods depending on color
  def print_board(color)
    white_print_board if color == "white"
    black_print_board if color == "black"
  end

  # Prints the board with white at the bottom
  def white_print_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts ""
    puts "+---+---+---+---+---+---+---+---+".center(54)
    board.reverse.each_with_index do |row, index|
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

  # Prints the board with black at the bottom
  def black_print_board # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts ""
    puts "+---+---+---+---+---+---+---+---+".center(54)
    board.each_with_index do |row, index|
      print " ".center(8)
      print "#{index + 1} |"
      row.each do |piece|
        print piece.nil? ? "   |" : " #{piece&.symbol} |"
      end
      puts ""
      puts "+---+---+---+---+---+---+---+---+".center(54)
    end
    puts "a   b   c   d   e   f   g   h".center(54)
    puts ""
  end
end
