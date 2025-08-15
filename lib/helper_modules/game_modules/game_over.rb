# Handles all the print statement for different conditions
module GameOver
  # Handles Checkmate
  def checkmate?
    color = nil
    color = "white" if checkmate_for?("white")
    color = "black" if checkmate_for?("black")

    unless color.nil?
      print_checkmate(color)
      return true
    end

    false
  end

  # Checks if checkmate is true
  def checkmate_for?(color)
    return true if in_check?(board.board, color) && in_checkmate?(color)

    false
  end

  # Print statement for when either king is in checkmate
  def print_checkmate(color)
    puts " #{color.capitalize} king is in checkmate".colorize(:red)
    puts ""
  end

  # Handles when either king is in stalemate
  def stalemate?
    if in_stalemate?("white") || in_stalemate?("black")
      print_stalemate
      return true
    end

    false
  end

  # Checks if stalemate is true
  def in_stalemate?(color)
    return true if in_check?(board.board, color) == false &&
                   in_checkmate?(color) &&
                   current_player.color != color

    false
  end

  # Print statement for when either king is in stalemate
  def print_stalemate?
    puts " Stalemate. Draw".colorize(:red)
    puts ""
  end

  # Checks if insufficient material is true
  def insufficient_material?
    if checkmate_isnt_possible?
      print_insufficient_material
      return true
    end

    false
  end

  # Print statement for when either there is insufficient material
  def print_insufficient_material
    puts " Insufficinet material. Draw".colorize(:red)
    puts ""
  end

  # Checks if threefold repetition is true
  def threefold_repetition?
    if draw_by_repetition?
      print_threefold_repetition
      return true
    end

    false
  end

  # Print statement for when threefold reptition rule is enforcable
  def print_threefold_repetition
    puts " Threefold repetition. Draw".colorize(:red)
    puts ""
  end

  # Print statement for 50 move rule
  def draw_game
    puts " 50 move rule. Draw".colorize(:red)
    puts ""
  end
end
