# This handles converting a fen str to a new board
module ConvertFromFen
  # Converts the board from a fen string to a 2d array
  def convert_board_from_fen(fen_str)
    new_fen_str = convert_nums_to_dots(fen_str)
    create_new_board(new_fen_str)
  end

  # Converts the numbers in the fen string to dots
  def convert_nums_to_dots(fen_str)
    new_fen_str = ""
    fen_str.split("/").each do |row|
      row.chars.each do |char|
        convert_char(char) { |var| new_fen_str += var }
      end
      new_fen_str += "/"
    end

    new_fen_str
  end

  # Gets a number and returns the same number of dots
  def convert_char(char)
    yield char if char.to_i.zero?

    char.to_i.times do
      yield "."
    end
  end

  # Loop through the fen string and updates and adds the piece to its correct position
  def create_new_board(fen_str)
    board = Array.new(8) { Array.new(8) }

    fen_str.split("/").each_with_index do |row, row_index|
      row.chars.each_with_index do |piece, piece_index|
        board[row_index][piece_index] = convert_piece(piece)
      end
    end

    board
  end

  # Convers the character into is piece
  def convert_piece(piece)
    return nil if piece == "."

    return handle_white_piece(piece) if %w[P N B R Q K].include?(piece)

    handle_black_piece(piece) if %w[p n b r q k].include?(piece)
  end

  # Turns the uppercase letters into white pieces
  def handle_white_piece(piece) # rubocop:disable Metrics/MethodLength
    case piece
    when "P"
      WhitePawn.new("pawn", "\u265f", "white")
    when "N"
      Knight.new("knight", "\u265e", "white")
    when "B"
      Bishop.new("bishop", "\u265d", "white")
    when "R"
      Rook.new("rook", "\u265c", "white")
    when "Q"
      Queen.new("queen", "\u265b", "white")
    when "K"
      King.new("king", "\u265a", "white")
    end
  end

  # Turns the lowercase letters into black pieces
  def handle_black_piece(piece) # rubocop:disable Metrics/MethodLength
    case piece
    when "p"
      BlackPawn.new("pawn", "\u2659", "black")
    when "n"
      Knight.new("knight", "\u2658", "black")
    when "b"
      Bishop.new("bishop", "\u2657", "black")
    when "r"
      Rook.new("rook", "\u2656", "black")
    when "q"
      Queen.new("queen", "\u2655", "black")
    when "k"
      King.new("king", "\u2654", "black")
    end
  end
end
