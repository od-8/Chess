# Handles Loading a new game
module LoadGame
  def load_prev_game(prev_game_name)
    game_info = YAML.load_file("lib/saved_games/#{prev_game_name}.yaml")
    update_player(game_info[2])
    update_game(game_info[0])
    update_board(game_info[1])
  end

  def update_game(game_info)
    @current_player = player1.name == game_info[:current_player_name] ? @player1 : @player2
    @current_king = [game_info[:current_king_cords], game_info[:current_king_color]]
    @invalid_moves = game_info[:invalid_moves]
  end

  def update_board(game_info)
    new_board = board.convert_from_fen(game_info[:board])
    board.previous_boards = game_info[:previous_boards]
    board.board = new_board
    update_passantable_pawn(game_info)
  end

  def update_passantable_pawn(game_info)
    passant_cords = game_info[:passantable_pawn_cords]
    piece = board.board[passant_cords[0]][passant_cords[1]]
    piece.can_be_passanted = true
    board.passantable_pawn_cords = passant_cords
  end

  def update_player(game_info)
    @player1 = Player.new(game_info[:player1_name], game_info[:player1_color])
    @player2 = Player.new(game_info[:player2_name], game_info[:player2_color])
  end
end
