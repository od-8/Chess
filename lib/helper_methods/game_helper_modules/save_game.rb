# methods for save and quit or quit without saving
module SaveGame
  def end_the_game
    choice = end_game_choice
    return "quit" if choice == "quit"

    file_name = acquire_new_file_name
    # save_game_information
    create_new_file(file_name)
  end

  def end_game_choice
    loop do
      puts ""
      puts "Would you like to save and quit or quit without saving"
      print "Enter #{'save'.colorize(:green)} to save and quit or #{'quit'.colorize(:green)} to quit without saving: "
      choice = gets.chomp.downcase
      puts ""
      return choice if %w[save quit].include?(choice)

      puts "Enter a valid answer"
      puts ""
    end
  end

  def acquire_new_file_name
    Dir.chdir("lib/saved_games")
    loop do
      puts "The game is being saved, please enter the name of the file you would like to save this game as."
      print "Without file extension and file doesnt already exist: "
      file_name = gets.chomp.downcase
      puts ""
      return file_name unless file_name.include?(".") || File.exist?("#{file_name}.yaml")

      puts "Your file cannot have dots in its name and its name must be unique".colorize(:red)
      puts ""
    end
  end

  def create_new_file(file_name)
    game_info = [acquire_game_info, acquire_board_info, acquire_player_info]
    puts game_info.to_yaml
    File.write("#{file_name}.yaml", game_info.to_yaml)
    # `rm #{file_name}.yaml`
  end

  def acquire_game_info
    {
      current_player_name: current_player.name,
      current_player_color: current_player.color,
      current_king_cords: current_king[0],
      current_king_color: current_king[1],
      invalid_moves: invalid_moves
    }
  end

  def acquire_board_info
    {
      board: board.convert_to_fen(board.board),
      previous_boards: board.previous_boards
      # passantable_pawn: board.passantable_pawn
    }
  end

  def acquire_player_info
    {
      player1_name: player1.name,
      player1_color: player1.color,
      player2_name: player2.name,
      player2_color: player2.color
    }
  end
end
