# Handles updating the board and pieces on the board
module LoadPreviousGame
  # Loads previous board info
  def update_board_info(previous_boards, passant_cords, castling, half_moves, full_moves)
    @previous_boards = previous_boards

    @passantable_pawn_cords = passant_cords
    board[passant_cords[0]][passant_cords[1]]&.can_be_passanted = true unless passant_cords.nil?

    @half_moves = half_moves.to_i
    @full_moves = full_moves.to_i

    update_castling_rights(castling)
  end

  # Updates pieces involved in castling
  def update_castling_rights(castling)
    return if castling.length == 4

    if castling == "-"
      update_king_castling
      return
    end

    white_castling, black_castling = seperate_castling_chars(castling)

    update_white_castling_vars(white_castling)
    update_black_castling_vars(black_castling)
  end

  def update_king_castling
    white_king_cords = find_king_coordinates(board, "white")
    black_king_cords = find_king_coordinates(board, "black")

    board[white_king_cords[0]][white_king_cords[1]]&.has_moved = true
    board[black_king_cords[0]][black_king_cords[1]]&.has_moved = true
  end

  # Seperate the black castling moves from the white ones
  def seperate_castling_chars(castling)
    white_str = ""
    black_str = ""

    castling.chars.each do |char|
      char.capitalize == char ? white_str += char : black_str += char
    end

    [white_str, black_str]
  end

  # Updates the white king and white rooks info
  def update_white_castling_vars(castling)
    return if castling.length == 2

    if castling.length == 1
      update_white_rook(castling)
    elsif castling.empty?
      king_cords = find_king_coordinates(board, "white")

      board[king_cords[0]][king_cords[1]]&.has_moved = true
    end
  end

  # Updates white rook info
  def update_white_rook(letter)
    rook = find_rook("white", [7, 7]) if letter == "K"
    rook = find_rook("white", [7, 0]) if letter == "Q"

    rook.has_moved = true unless rook.nil?
  end

  # Updates the black king and black rooks info
  def update_black_castling_vars(castling)
    return if castling.length == 2

    if castling.length == 1
      update_black_rook(castling)
    elsif castling.empty?
      king_cords = find_king_coordinates(board, "black")

      board[king_cords[0]][king_cords[1]]&.has_moved = true
    end
  end

  # Updates black rook info
  def update_black_rook(letter)
    rook = find_rook("black", [0, 7]) if letter == "k"
    rook = find_rook("black", [0, 0]) if letter == "q"

    rook.has_moved = true unless rook.nil?
  end

  # Gets the position of the rook that has been moved
  def find_rook(color, unmoved_rook_cords)
    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        return piece if piece&.name == "rook" && piece&.color == color && unmoved_rook_cords != [row_index, piece_index]
      end
    end
  end
end
