# Contains all the methods for getting player input like "a1"
# and turning it into coordinates like [0, 0]
module GetCoordinates
  # This repeats until a players cords are valid then turns them into usable coordinates
  def legal_input
    invalid_moves = 22
    cords = []

    loop do
      cords = take_input
      invalid_moves += 3

      next unless valid_coordinaates?(cords[0]) && valid_coordinaates?(cords[1])

      cords.map! { |position| to_cords(position) }

      break if correct_color?(cords[0])
    end
    cords << invalid_moves
  end

  # Gets the peice the user would like to move and where they would like to move it
  def take_input
    print "     #{current_player.name}, input position of the peice you would like to move: "
    piece_cords = gets.chomp.downcase
    print " #{current_player.name}, input position of where you would like to move that peice: "
    move_cords = gets.chomp.downcase
    puts ""

    [piece_cords, move_cords]
  end

  # Makes sure both cords are valid and have a length of 2
  def valid_coordinaates?(cords)
    letter = cords[0]
    number = cords[1].to_i - 1

    return true if letter.between?("a", "h") && number.between?(0, 7) && cords.length == 2

    false
  end

  # Turns coordinates like [a, 1] into [0, 0]
  def to_cords(cords)
    alphabet = ("a".."h").to_a

    [cords[1].to_i - 1, alphabet.find_index(cords[0])]
  end

  # Checks to make sure the player is choosing their color pieces only
  def correct_color?(piece_cords)
    return true if board.board[piece_cords[0]][piece_cords[1]]&.color == current_player.color

    false
  end
end
