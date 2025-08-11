require_relative "../../../lib/helper_modules/game_modules/save_game"
require_relative "../../../lib/board"
require_relative "../../../lib/game"
require_relative "../../../lib/player"

RSpec.describe SaveGame do
  subject(:test_game) do
    game = Game.new("player1", "player2")
    game.instance_variable_set(:@board, test_board)
    game
  end

  let(:test_board) do
    board = Board.new("8/8/8/8/8/8/8/8/")
    previous_board = [["rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq 0 1 "],
                      ["rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR b KQkq 0 1"]]
    board.instance_variable_set(:@previous_boards, previous_board)
    board.instance_variable_set(:@passantable_pawn_cords, [3, 3])
    board
  end

  describe "#create_new_file" do
    context "when creating a new file" do
      it "creates a new file" do
        expect(File).to receive(:write).once # rubocop:disable RSpec/MessageSpies
        test_game.create_new_file("game")
      end
    end
  end

  describe "#board_info" do
    context "when getting the board info" do
      let(:hash_info) do
        {
          board: ["rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR b KQkq 0 1"],
          previous_boards: [["rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq 0 1 "],
                            ["rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR b KQkq 0 1"]],
          passantable_pawn_cords: [3, 3]
        }
      end

      it "returns a hash with the board (fen), previous board (fen) and the passantable cords" do
        board_info = test_game.board_info
        expect(board_info).to eq(hash_info)
      end
    end
  end

  describe "#plyaer_info" do
    context "when getting the player info" do
      let(:hash_info) { { player1: %w[player1 white], player2: %w[player2 black] } }

      it "returns a hash with player 1 and player 2's names and their colors" do
        player_info = test_game.player_info
        expect(player_info).to eq(hash_info)
      end
    end
  end
end
