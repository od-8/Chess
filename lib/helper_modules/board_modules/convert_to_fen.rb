# This handles converting a board to fen and converting a fen board into a regular board
module ConvertToFen
  # Converts the board to a fen string and adds game info
  def convert_to_fen(board, color)
    fen_str = convert_board_to_fen(board)
    fen_str += " #{color[0]} "
    fen_str += fen_castling
    fen_str += fen_move_counts
    fen_str
  end

  # Converts the board to a fen string
  def convert_board_to_fen(board)
    fen_board = convert_pieces_to_fen(board)
    fen_board_arr = convert_to_fen_arr(fen_board)
    fen_board_arr.join
  end

  # Converts the piece to letters
  def convert_pieces_to_fen(board)
    fen_board = ""
    board.each do |row|
      row.each do |piece|
        fen_board += "." if piece.nil?

        fen_board += convert_piece_to_fen(piece) unless piece.nil?
      end
      fen_board += "/"
    end
    fen_board[0..-2]
  end

  # Handles which letter to return depending on color
  def convert_piece_to_fen(piece)
    return "N" if piece.color == "white" && piece.name == "knight"

    return "n" if piece.color == "black" && piece.name == "knight"

    return piece.name[0].capitalize if piece.color == "white"

    piece.name[0] if piece.color == "black"
  end

  # Turns the dots into numbers
  def convert_to_fen_arr(fen_board) # rubocop:disable Metrics/MethodLength
    fen_arr = []
    counter = 0

    fen_board.chars.each_with_index do |char, index|
      counter += 1 if char == "."

      unless char == "."
        counter = 0
        fen_arr << char
        next
      end

      fen_arr << counter if fen_board.chars[index + 1] != "."
    end

    fen_arr
  end

  # Adds the move counters to the fen string
  def fen_move_counts
    fen_str = ""
    fen_str += " #{half_moves}"
    fen_str += " #{full_moves}"
    fen_str
  end

  # Converts the castling rights to fen
  def fen_castling
    fen_str = ""

    fen_str += white_castling_moves
    fen_str += black_castling_moves

    return fen_str if fen_str.length.positive?

    "-"
  end

  # Gets all legal castling moves for white
  def white_castling_moves
    return "" if board[7][4]&.name != "king" || board[7][4]&.has_moved == true

    fen_str = ""
    fen_str += "K" if legal_castling?(7, 7)
    fen_str += "Q" if legal_castling?(7, 0)
    fen_str
  end

  # Gets all legal castling moves for black
  def black_castling_moves
    return "" if board[0][4]&.name != "king" || board[0][4]&.has_moved == true

    fen_str = ""
    fen_str += "k" if legal_castling?(0, 7)
    fen_str += "q" if legal_castling?(0, 0)
    fen_str
  end

  # Makes sure the rook hasnt moved
  def legal_castling?(row, column)
    return true if board[row][column]&.name == "rook" && board[row][column]&.has_moved == false

    false
  end
end
