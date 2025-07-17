# This handles converting a fen str to a new board
module ConvertFromFen
  def convert_to_board(fen_str)
    new_fen_str = convert_nums_to_dots(fen_str)
    create_new_board(new_fen_str)
  end

  def convert_nums_to_dots(fen_str)
    new_fen_str = ""
    fen_str.split("/").each do |row|
      row.chars.each do |char|
        convert_char(char) { |var| @fen_str += var }
      end
      new_fen_str += "/"
    end

    new_fen_str
  end

  def convert_char(char)
    yield char if char.to_i.zero?

    char.to_i.times do
      yield "."
    end
  end

  def create_new_board(fen_str)
    board = Array.new(8) { Array.new(8) }

    fen_str.split("/").each_with_index do |row, row_index|
      row.chars.each_with_index do |piece, piece_index|
        board[row_index][piece_index] = convert_piece(piece)
      end
    end

    board
  end

  def convert_piece(piece)
    return nil if piece == "."

    return handle_white_piece(piece) if %w[P N B R Q K].include?(piece)

    handle_black_piece(piece) if %w[p n b r q k].include?(piece)
  end

  def handle_white_piece(piece) # rubocop:disable Metrics/MethodLength
    case piece # rubocop:disable Style/HashLikeCase
    when "P"
      "Pawn"
    when "N"
      "Knight"
    when "B"
      "Bishop"
    when "R"
      "RooK"
    when "Q"
      "Queen"
    when "K"
      "King"
    end
  end

  def handle_black_piece(piece) # rubocop:disable Metrics/MethodLength
    case piece # rubocop:disable Style/HashLikeCase
    when "p"
      "pawn"
    when "n"
      "knight"
    when "b"
      "bishop"
    when "r"
      "rooK"
    when "q"
      "queen"
    when "k"
      "king"
    end
  end
end
