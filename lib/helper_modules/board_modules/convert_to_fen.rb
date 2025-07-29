# This handles converting a board to fen and converting a fen board into a regular board
module ConvertToFen
  # Converts the board (2d array) to a string as fen
  def convert_to_fen(board, color)
    fen_str = convert_board_to_fen(board)
    fen_str += " #{color[0]} "
    fen_str += fen_castling
    fen_str += fen_move_counts
    fen_str
  end

  def convert_board_to_fen(board)
    fen_board = convert_pieces_to_fen(board)
    fen_board_arr = convert_to_fen_arr(fen_board)
    fen_board_arr.join
  end

  # Converts the board to fen notation, not completed yet
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
  def convert_piece_to_fen(piece) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity
    return piece.name[0].capitalize if piece.color == "white" && piece.name != "knight"

    return "N" if piece.color == "white" && piece.name == "knight"

    return "n" if piece.color == "black" && piece.name == "knight"

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

  # Converts the castling rights to fen
  def fen_castling # rubocop:disable Metrics/AbcSize
    wx, wy = find_king_coordinates(board, "white")
    bx, by = find_king_coordinates(board, "black")

    fen_str = ""
    fen_str += "K" if board[wx][wy].king_side_is_legal?(board, wx, wy)
    fen_str += "Q" if board[wx][wy].queen_side_is_legal?(board, wx, wy)
    fen_str += "k" if board[bx][by].king_side_is_legal?(board, bx, by)
    fen_str += "q" if board[bx][by].queen_side_is_legal?(board, bx, by)

    return fen_str if fen_str.length.positive?

    "-"
  end

  def fen_move_counts
    fen_str = ""
    fen_str += " #{half_moves}"
    fen_str += " #{full_moves}"
    fen_str
  end
end
