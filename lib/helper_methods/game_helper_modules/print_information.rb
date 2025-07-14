# Handles all the print statement for different conditions
module PrintInfo
  # Checks if check is true
  def check?
    return true if print_check?(white_king_cords, "white") || print_check?(black_king_cords, "black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_check?(king_cords, color)
    return unless in_check?(board.board, king_cords, color)

    @invalid_moves += 2
    puts "#{color.capitalize} king is in check".colorize(:green)
    puts ""
  end

  # Checks if checkmate is true
  def checkmate?
    return true if print_checkmate?(white_king_cords, "white") || print_checkmate?(black_king_cords, "black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_checkmate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) && in_checkmate?(king_cords, color)

    puts "#{color.capitalize} king is in checkmate".colorize(:red)
    puts ""

    true
  end

  # Checks if stalemate is true
  def stalemate?
    return true if print_stalemate?(white_king_cords, "white") || print_stalemate?(black_king_cords, "black")

    false
  end

  # Print statement for when either king is in stalemate
  def print_stalemate?(king_cords, color)
    return unless in_check?(board.board, king_cords, color) == false &&
                  in_checkmate?(king_cords, color) &&
                  current_player.color != color

    puts "It is #{color}'s go and they cant make any legal moves. Stalemate".colorize(:red)
    puts ""

    true
  end

  # Checks if there arent enough pieces on the board
  def insufficient_material?
    return unless checkmate_isnt_possible?

    puts "Insufficinet material. Draw".colorize(:red)
    puts ""

    true
  end

  # Checks if the same board has appeared three times
  def threefold_repetition?
    return unless draw_by_repetition?

    puts "Threefold repetition. Draw".colorize(:red)
    puts ""

    true
  end
end
