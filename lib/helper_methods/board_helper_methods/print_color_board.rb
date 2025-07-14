# This is a feature im not sure I like, I maybe will use or maybe not
module PrintColorBoard
  # Prints the board so it looks like a chess board
  def print_board(color)
    white_print_board if color == "white"
    black_print_board if color == "black"
  end

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
