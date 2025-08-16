require_relative "../../../lib/helper_modules/game_modules/game_over"
require_relative "../../../lib/board"
require_relative "../../../lib/game"
require_relative "../../../lib/player"

RSpec.describe GameOver do
  subject(:test_game) do
    game = Game.new
    game.instance_variable_set(:@board, test_board)
    game.instance_variable_set(:@current_player, test_player)
    game
  end

  let(:test_player) { instance_double(Player) }
  let(:test_board) { instance_double(Board) }

  describe "#check?" do
    context "when check is true for white" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in check statement for white" do
        test_game.check?

        check_line = "\e[0;32;49m White king is in check\e[0m"
        expect(test_game).to have_received(:puts).with(check_line) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.check?
        expect(result).to be(true)
      end
    end

    context "when check is true for black" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in check statement for black" do
        test_game.check?

        check_line = "\e[0;32;49m Black king is in check\e[0m"
        expect(test_game).to have_received(:puts).with(check_line) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.check?
        expect(result).to be(true)
      end
    end

    context "when neither are in check" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive(:in_check?).and_return(false)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        result = test_game.check?
        expect(result).to be(false)
      end
    end
  end

  describe "#checkmate?" do
    context "when checkmate is true for white" do
      before do
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(true)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(false)
        allow(test_board).to receive(:board)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in checkmate statement for white" do
        test_game.checkmate?

        checkmate_line = "\e[0;31;49m White king is in checkmate\e[0m"
        expect(test_game).to have_received(:puts).with(checkmate_line).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        checkmate = test_game.checkmate?

        expect(checkmate).to be(true)
      end
    end

    context "when checkmate is true for black" do
      before do
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(false)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(true)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(true)
        allow(test_board).to receive(:board)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in checkmate statement for black" do
        test_game.checkmate?

        checkmate_line = "\e[0;31;49m Black king is in checkmate\e[0m"
        expect(test_game).to have_received(:puts).with(checkmate_line).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.checkmate?

        expect(result).to be(true)
      end
    end

    context "when checkmate isnt true" do
      before do
        allow(test_board).to receive_messages(in_check?: false, in_checkmate?: false)
        allow(test_board).to receive(:board)
        allow(test_game).to receive(:print_checkmate) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        result = test_game.checkmate?

        expect(result).to be(false)
      end
    end
  end

  describe "#checkmate_for?" do
    context "when white is in checkmate" do
      before do
        allow(test_board).to receive_messages(in_check?: true, in_checkmate?: true)
        allow(test_board).to receive(:board)
      end

      it "returns true" do
        result = test_game.checkmate_for?("white")

        expect(result).to be(true)
      end
    end

    context "when black isnt in checkmate" do
      before do
        allow(test_board).to receive_messages(in_check?: true, in_checkmate?: false)
        allow(test_board).to receive(:board)
      end

      it "returns false" do
        result = test_game.checkmate_for?("black")

        expect(result).to be(false)
      end
    end
  end

  describe "#stalemate?" do
    context "when white is in stalemate" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(true)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(false)
        allow(test_player).to receive(:color).and_return("black")
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in stalemate statement" do
        test_game.stalemate?

        stalemate_line = "\e[0;31;49m Stalemate. Draw\e[0m"
        expect(test_game).to have_received(:puts).with(stalemate_line).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.stalemate?
        expect(result).to be(true)
      end
    end

    context "when black is in stalemate" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive(:in_check?).with(nil, "white").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("white").and_return(false)
        allow(test_board).to receive(:in_check?).with(nil, "black").and_return(false)
        allow(test_board).to receive(:in_checkmate?).with("black").and_return(true)
        allow(test_player).to receive(:color).and_return("white")
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print in stalemate statement" do
        test_game.stalemate?

        stalemate_line = "\e[0;31;49m Stalemate. Draw\e[0m"
        expect(test_game).to have_received(:puts).with(stalemate_line).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.stalemate?
        expect(result).to be(true)
      end
    end

    context "when neither are in stalemate" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_check?: false, in_checkmate?: false)
        allow(test_player).to receive(:color)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns false" do
        result = test_game.stalemate?
        expect(result).to be(false)
      end
    end
  end

  describe "#in_stalemate?" do
    context "when white is in stalemate" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_check?: false, in_checkmate?: true)
        allow(test_player).to receive(:color).and_return("black")
      end

      it "returns true" do
        result = test_game.in_stalemate?("white")
        expect(result).to be(true)
      end
    end

    context "when black isnt in stalemate" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_check?: true, in_checkmate?: true)
        allow(test_player).to receive(:color).and_return("white")
      end

      it "returns false" do
        result = test_game.in_stalemate?("black")
        expect(result).to be(false)
      end
    end
  end

  describe "#insufficient_material?" do
    context "when insufficent material is true" do
      before do
        allow(test_board).to receive(:insufficient_material?).and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "prints insufficient material statement" do
        test_game.insufficient_material?

        insufficient_material_line = "\e[0;31;49m Insufficinet material. Draw\e[0m"
        expect(test_game).to have_received(:puts).with(insufficient_material_line).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.insufficient_material?

        expect(result).to be(true)
      end
    end

    context "when insufficient material is false" do
      before do
        allow(test_board).to receive(:insufficient_material?).and_return(false)
      end

      it "returns false" do
        result = test_game.insufficient_material?

        expect(result).to be(false)
      end
    end
  end

  describe "threefold_repetition?" do
    context "when threefold repetition is true" do
      before do
        allow(test_board).to receive(:threefold_repetition?).and_return(true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "print threefold repetition statement" do
        test_game.threefold_repetition?

        threefold_repetition_line = "\e[0;31;49m Threefold repetition. Draw\e[0m"
        expect(test_game).to have_received(:puts).with(threefold_repetition_line) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.threefold_repetition?
        expect(result).to be(true)
      end
    end

    context "when threefold_repitition is false" do
      before do
        allow(test_board).to receive(:threefold_repetition?).and_return(false)
      end

      it "returns false" do
        result = test_game.threefold_repetition?
        expect(result).to be(false)
      end
    end
  end
end
