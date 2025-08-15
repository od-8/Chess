# methods for save and quit or quit without saving
module SaveGame
  # Gets the name and creates a new file
  def save_game
    file_name = new_file_name
    create_new_file(file_name)
  end

  # Gets the new file name
  def new_file_name
    Dir.chdir("lib/saved_games")
    loop do
      puts ""
      print " Please name this game: "
      file_name = gets.chomp.downcase
      return file_name unless file_name.include?(".") || File.exist?("#{file_name}.yaml")

      puts ""
      puts " The name must be unique and it cannot contain any dots".colorize(:red)
    end
  end

  # Creates the new file and adds the game info to it
  def create_new_file(file_name)
    game_info = [board_info, player_info]

    File.write("#{file_name}.yaml", game_info.to_yaml)
  end

  # Gets the board info
  def board_info
    {
      board: board.previous_boards[-1],
      previous_boards: board.previous_boards,
      passantable_pawn_cords: board.passantable_pawn_cords
    }
  end

  # Gets the player info
  def player_info
    {
      player1: [player1.name, player1.color],
      player2: [player2.name, player2.color]
    }
  end
end
