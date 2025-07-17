# This handles converting a board to fen and converting a fen board into a regular board
module ConvertToFen
  # Converts the board (2d array) to a string as fen
  def convert_to_fen
    fen_board = convert_pieces_to_fen
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
    fen_board
  end

  # Handles which letter to return depending on color
  def convert_piece_to_fen(piece)
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
end
