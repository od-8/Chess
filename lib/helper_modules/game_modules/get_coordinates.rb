# Gets the coordinates from the current player then turns them into usable cords ("a1" = [0, 0])
module GetCoordinates
  # This repeats until a players cords are valid then turns them into usable coordinates
  def legal_input
    cords = []

    loop do
      cords = take_input
      @lines_to_clear += 3

      return cords if draw_or_quit?(cords)

      next unless valid_coordinates?(cords)

      cords.map! { |position| to_cords(position) }

      break if correct_color?(cords[0])
    end
    cords
  end

  # Gets the chess cords of the piece the player is moving and where theyd like to move it
  def take_input
    print " #{current_player.name}, input the position of the piece you would like to move: "
    piece_cords = gets.chomp.downcase
    return "quit" if piece_cords == "q"

    print " #{current_player.name}, input the position of where you would like to move that peice: "
    move_cords = gets.chomp.downcase
    puts ""

    [piece_cords, move_cords]
  end

  def valid_coordinates?(cords)
    return false if cords[0] == "" || cords[1] == ""

    return true if legal_coordinates?(cords[0]) &&
                   legal_coordinates?(cords[1])

    false
  end

  # Makes sure both cords are valid and have a length of 2
  def legal_coordinates?(cords)
    letter = cords[0]
    number = 8 - cords[1].to_i

    return true if letter.between?("a", "h") && number.between?(0, 7) && cords.length == 2

    false
  end

  # Turns coordinates like [a, 1] into [0, 0]
  def to_cords(cords)
    alphabet = ("a".."h").to_a

    [8 - cords[1].to_i, alphabet.find_index(cords[0])]
  end

  # Checks to make sure the player is choosing their color pieces only
  def correct_color?(piece_cords)
    return true if board.board[piece_cords[0]][piece_cords[1]]&.color == current_player.color

    false
  end

  def draw_or_quit?(cords)
    return true if cords == "quit" ||
                   (cords == "draw" && board.half_moves > 99)

    false
  end
end
