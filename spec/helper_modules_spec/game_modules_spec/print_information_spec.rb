require_relative "../../../lib/helper_modules/game_modules/print_information"
require_relative "../../../lib/board"
require_relative "../../../lib/game"
require_relative "../../../lib/player"

RSpec.describe PrintInfo do
  subject(:test_game) do
    game = Game.new
    game.instance_variable_set(:@board, test_board)
    game.instance_variable_set(:@current_player, test_player)
    game
  end

  let(:test_player) { instance_double(Player) }
  let(:test_board) { instance_double(Board) }

  describe "#print_checkmate?" do
    context "when white king is in checkmate" do
      before do
        allow(test_board).to receive(:board).and_return(nil)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        color = "white"
        checkmate = test_game.print_checkmate?(color)
        expect(checkmate).to be(true)
      end
    end

    context "when black king isnt in checkmate" do
      before do
        allow(test_board).to receive(:board).and_return(nil)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(false)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        color = "black"
        checkmate = test_game.print_checkmate?(color)
        expect(checkmate).to be(false)
      end
    end
  end

  describe "#print_stalemate?" do
    context "when black king is in stalemate" do
      before do
        allow(test_board).to receive(:board).and_return(nil)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(false)
        allow(test_player).to receive(:color).and_return("white")
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        color = "black"
        stalemate = test_game.print_stalemate?(color)
        expect(stalemate).to be(true)
      end
    end

    context "when white king isnt in stalemate" do
      before do
        allow(test_board).to receive(:board).and_return(nil)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(true)
        allow(test_player).to receive(:color).and_return("black")
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        color = "white"
        stalemate = test_game.print_stalemate?(color)
        expect(stalemate).to be(false)
      end
    end
  end

  describe "#insufficient_material?" do
    context "when there is enough material on the board" do
      before do
        allow(test_board).to receive(:insufficient_material?).and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        insufficient_material = test_game.insufficient_material?
        expect(insufficient_material).to be(true)
      end
    end

    context "when there isnt enough material on the board" do
      before do
        allow(test_board).to receive(:insufficient_material?).and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        insufficient_material = test_game.insufficient_material?
        expect(insufficient_material).to be(false)
      end
    end
  end

  describe "#threefold_repitition?" do
    context "when there is threefold reptetition" do
      before do
        allow(test_board).to receive(:threefold_repetition?).and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        threefold_repitition = test_game.threefold_repetition?
        expect(threefold_repitition).to be(true)
      end
    end

    context "when there isnt threefold repetition" do
      before do
        allow(test_board).to receive(:threefold_repetition?).and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        insufficient_material = test_game.threefold_repetition?
        expect(insufficient_material).to be(false)
      end
    end
  end

  describe "#fifty_move_rule?" do
    context "when the game has reached the 50 move mark" do
      before do
        allow(test_board).to receive(:fifty_move_rule?).and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        fifty_move_rule = test_game.fifty_move_rule?
        expect(fifty_move_rule).to be(true)
      end
    end

    context "when the game hasnt reached the 50 move mark" do
      before do
        allow(test_board).to receive(:fifty_move_rule?).and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        fifty_move_rule = test_game.fifty_move_rule?
        expect(fifty_move_rule).to be(false)
      end
    end
  end
end
