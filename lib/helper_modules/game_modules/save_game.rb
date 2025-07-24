# methods for save and quit or quit without saving
module SaveGame
  # Ends the game but with different results depending on a players answer
  def end_the_game
    choice = end_game_choice
    return "quit" if choice == "quit"

    file_name = acquire_new_file_name
    create_new_file(file_name)
  end

  # Sees if the player wants to save and quit or quit without saving
  def end_game_choice
    loop do
      puts ""
      print "Enter #{'save'.colorize(:green)} to save and quit or #{'quit'.colorize(:green)} to quit without saving: "
      choice = gets.chomp.downcase
      return choice if %w[save quit].include?(choice)

      puts "Enter either the word save or the word quit".colorize(:red)
    end
  end

  # Gets the new file name
  def acquire_new_file_name
    Dir.chdir("lib/saved_games")
    loop do
      puts ""
      print "Please name this game: "
      file_name = gets.chomp.downcase
      return file_name unless file_name.include?(".") || File.exist?("#{file_name}.yaml")

      puts ""
      puts "The name must be unique and it cannot contain any dots".colorize(:red)
    end
  end

  # Creates the new file and adds the game info to it
  def create_new_file(file_name)
    game_info = [acquire_game_info, acquire_board_info, acquire_player_info]
    File.write("#{file_name}.yaml", game_info.to_yaml)
  end

  # Gets the game info
  def acquire_game_info
    {
      current_player_name: current_player.name,
      current_player_color: current_player.color,
      current_king_cords: current_king[0],
      current_king_color: current_king[1],
      white_king_cords: white_king_cords,
      black_king_cords: black_king_cords
    }
  end

  # Gets the board info
  def acquire_board_info
    {
      board: board.convert_to_fen(board.board),
      previous_boards: board.previous_boards,
      passantable_pawn_cords: board.passantable_pawn_cords
    }
  end

  # Gets the player info
  def acquire_player_info
    {
      player1_name: player1.name,
      player1_color: player1.color,
      player2_name: player2.name,
      player2_color: player2.color
    }
  end

  def acquire_info
    
  end
end
