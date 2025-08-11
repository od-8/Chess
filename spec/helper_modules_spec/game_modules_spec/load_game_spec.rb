require_relative "../../../lib/helper_modules/game_modules/load_game"
require_relative "../../../lib/board"
require_relative "../../../lib/game"
require_relative "../../../lib/player"

RSpec.describe LoadGame do
  subject(:test_game) { Game.new }

  describe "#load_prev_game" do
    context "when loading a previous game" do
      let(:fake_data) { [{ board: "fake board" }, "fake_player"] }

      before do
        allow(test_game).to receive(:update_player) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:update_game) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:update_board) # rubocop:disable RSpec/SubjectStub
      end

      it "loads a saved game, from the directory saved_games, the file is in yaml format" do
        expect(YAML).to receive(:load_file).with("lib/saved_games/game.yaml").once.and_return(fake_data) # rubocop:disable RSpec/MessageSpies
        test_game.load_prev_game("game")
      end
    end
  end

  describe "#update_game" do
    context "when updating the current player" do
      let(:game_info) { "8/8/8/8/8/8/8/8/ w KQkq 0 1" }

      before do
        test_game.update_game(game_info)
      end

      it "updates current_player" do
        expect(test_game.current_player).to eq(test_game.player1)
      end
    end
  end

  describe "#update_board" do
    context "when loading a previous board" do
      let(:board_info) do
        {
          board: "8/8/8/8/8/8/8/8/ w KQkq 0 1",
          previous_boards: [["rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq 0 1 "],
                            ["rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR b KQkq 0 1"]],
          passantable_pawn_cords: [3, 3]
        }
      end

      it "creates a new board" do
        test_game.update_board(board_info)
        expect(test_game.board).to be_an_instance_of(Board)
      end

      it "updates the board" do
        test_game.update_board(board_info)
        expect(test_game.board.board).to eq(Array.new(8) { Array.new(8) })
      end

      it "calls Board#update_board_info" do
        expect(test_game.board).to receive(:update_board_info).once # rubocop:disable RSpec/MessageSpies
        test_game.board.update_board_info(board_info[:previous_board], [3, 3], "KQkq", 0, 1)
      end
    end
  end

  describe "#update_player" do
    context "when loading the 2 previous players" do
      let(:player_info) { { player1: %w[player1 white], player2: %w[player2 black] } }

      before do
        test_game.update_player(player_info)
      end

      it "creates player 1" do
        expect(test_game.player1).to be_an_instance_of(Player)
      end

      it "creates player 2" do
        expect(test_game.player2).to be_an_instance_of(Player)
      end

      it "updates player 1 name" do
        expect(test_game.player1.name).to eq("player1")
      end

      it "updates player 2 name" do
        expect(test_game.player2.name).to eq("player2")
      end

      it "updates player 1 color" do
        expect(test_game.player1.color).to eq("white")
      end

      it "updates player 2 color" do
        expect(test_game.player2.color).to eq("black")
      end
    end
  end
end
