require "yaml"

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
      puts "The game is being saved, please enter the name of the file you would like to save this game as: "
      print "Without file extension (do not include .example in the name): "
      file_name = gets.chomp.downcase
      puts ""
      return file_name unless file_name.include?(".") || File.exist?("#{file_name}.yaml")

      puts "Your file cannot have dots (.) in it"
      puts ""
    end
  end

  def something # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    board_info = {
      fen_board: board.convert_to_fen(board.board),
      previous_boards: board.previous_boards
    }

    game_info = {
      current_player_name: current_player.name,
      current_player_color: current_player.color,
      white_king_cords: white_king_cords,
      black_king_cords: black_king_cords,
      current_king_cords: current_king[0],
      current_king_color: current_king[1],
      invalid_moves: invalid_moves
    }

    player_info = {
      player1_name: player1.name,
      player1_color: player1.color,
      player2_name: player2.name,
      player2_color: player2.color
    }
    [game_info, board_info, player_info]
  end

  def create_new_file(file_name)
    File.open("#{file_name}.yaml", "w")

    fen_board = board.convert_to_fen(board.board)
    info = {
      board: fen_board,
      player1: player1,
      player2: player2,
      white_king_cords: white_king_cords,
      black_king_cords: black_king_cords
    }

    puts info.to_yaml
  end
end
