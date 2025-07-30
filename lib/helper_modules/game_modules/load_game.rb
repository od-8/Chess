# Handles Loading a new game
module LoadGame
  # Gets the information from a file then updates the game
  def load_prev_game(prev_game_name)
    game_info = YAML.load_file("lib/saved_games/#{prev_game_name}.yaml")

    update_player(game_info[1])
    update_game(game_info[0][:board])
    update_board(game_info[0])
  end

  # Updates the Game, this will receive the fen version of the board
  def update_game(game_info)
    current_player_color = game_info.split[1]

    @current_player = current_player_color == "w" ? player1 : player2
  end

  # Updates the Board, this will receive the fen version of the board, passantable cords and previous boards
  def update_board(board_info)
    fen_board = board_info[:board].split

    @board = Board.new(fen_board[0])

    previous_boards = board_info[:previous_boards]
    passant_cords = board_info[:passantable_pawn_cords]
    castling = fen_board[2]
    half_moves = fen_board[3]
    full_moves = fen_board[4]

    board.update_board_info(previous_boards, passant_cords, castling, half_moves, full_moves)
  end

  # Adds the players to the game, this will recieve info on player 1 and info on player 2
  def update_player(player_info)
    player1_info = player_info[:player1]
    player2_info = player_info[:player2]

    @player1 = Player.new(player1_info[0], player1_info[1])
    @player2 = Player.new(player2_info[0], player2_info[1])
  end
end
