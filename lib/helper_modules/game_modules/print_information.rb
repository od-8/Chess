# Handles all the print statement for different conditions
module PrintInfo
  # Checks if check is true
  def check?
    return true if print_check?("white") || print_check?("black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_check?(color)
    return false unless in_check?(board.board, color)

    @invalid_moves += 2
    puts " #{color.capitalize} king is in check".colorize(:green)
    puts ""
  end

  # Checks if checkmate is true
  def checkmate?
    return true if print_checkmate?("white") || print_checkmate?("black")

    false
  end

  # Print statement for when either king is in checkmate
  def print_checkmate?(color)
    return false unless in_check?(board.board, color) && in_checkmate?(color)

    puts " #{color.capitalize} king is in checkmate".colorize(:red)
    puts ""

    true
  end

  # Checks if stalemate is true
  def stalemate?
    return true if print_stalemate?("white") || print_stalemate?("black")

    false
  end

  # Print statement for when either king is in stalemate
  def print_stalemate?(color)
    return false unless in_check?(board.board, color) == false &&
                        in_checkmate?(color) &&
                        current_player.color != color

    puts " It is #{color}'s go and they cant make any legal moves. Stalemate".colorize(:red)
    puts ""

    true
  end

  # Checks if there arent enough pieces on the board
  def insufficient_material?
    return false unless checkmate_isnt_possible?

    puts " Insufficinet material. Draw".colorize(:red)
    puts ""

    true
  end

  # Checks if the same board has appeared three times
  def threefold_repetition?
    return false unless draw_by_repetition?

    puts " Threefold repetition. Draw".colorize(:red)
    puts ""

    true
  end
end
