require_relative "../../../lib/helper_modules/game_modules/get_coordinates"
require_relative "../../../lib/game"
require_relative "../../../lib/board"
require_relative "../../../lib/player"
require_relative "../../../lib/pieces/bishop"

RSpec.describe GetCoordinates do
  subject(:test_game) do
    game = Game.new
    game.instance_variable_set(:@board, test_board)
    game.instance_variable_set(:@current_player, test_player)
    game
  end

  let(:test_player) { instance_double(Player) }
  let(:test_board) { Board.new("8/8/8/8/8/8/8/8") }

  describe "#legal_input" do
    context "when stopping game is false once" do
      before do
        allow(test_game).to receive(:take_input).and_return(%w[a9 b7], "quit") # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:valid_coordinates?) # rubocop:disable RSpec/SubjectStub
      end

      it "calls #take_input twice" do
        test_game.legal_input
        expect(test_game).to have_received(:valid_coordinates?).with(%w[a9 b7]).once # rubocop:disable RSpec/SubjectStub
      end

      it "returns quit" do
        result = test_game.legal_input
        expect(result).to eq("quit")
      end
    end

    context "when inputed cords are valid" do
      let(:test_bishop) { instance_double(Bishop) }

      before do
        test_board.board[7][0] = test_bishop
        allow(test_bishop).to receive(:color).and_return("white")
        allow(test_player).to receive(:color).and_return("white")
        allow(test_game).to receive(:take_input).and_return(%w[a1 h8]) # rubocop:disable RSpec/SubjectStub
      end

      it "returns valid coordiantes as integers in an array" do
        result = test_game.legal_input
        expect(result).to eq([[7, 0], [0, 7]])
      end
    end
  end

  describe "#valid_coordiantes?" do
    context "when the cords are valid" do
      it "returns true" do
        result = test_game.valid_coordinates?(%w[a1 h8])
        expect(result).to be(true)
      end
    end

    context "when one of the cords are an empty string" do
      it "returns false" do
        result = test_game.valid_coordinates?(["b4", ""])
        expect(result).to be(false)
      end
    end

    context "when one of the cords are invalid" do
      it "returns false" do
        result = test_game.valid_coordinates?(%w[b4 a9])
        expect(result).to be(false)
      end
    end
  end

  describe "#legal_coordiantes?" do
    context "when coordiantes are legal" do
      it "returns true" do
        cords = "a4"
        legal_coordiantes = test_game.legal_coordinates?(cords)
        expect(legal_coordiantes).to be(true)
      end
    end

    context "when number is illegal" do
      it "returns false" do
        cords = "a0"
        legal_coordiantes = test_game.legal_coordinates?(cords)
        expect(legal_coordiantes).to be(false)
      end
    end

    context "when letter is illegal" do
      it "returns false" do
        cords = "i5"
        legal_coordiantes = test_game.legal_coordinates?(cords)
        expect(legal_coordiantes).to be(false)
      end
    end
  end

  describe "#to_cords" do
    context "when coordiantes passed are a5" do
      it "returns [3, 0]" do
        coordiantes = test_game.to_cords("a5")
        expect(coordiantes).to eq([3, 0])
      end
    end
  end

  describe "#correct_color?" do
    let(:test_bishop) { instance_double(Bishop) }

    context "when the piece color is the same as the current_player color" do
      before do
        test_board.board[2][3] = test_bishop
        allow(test_bishop).to receive(:color).and_return("white")
        allow(test_game.current_player).to receive(:color).and_return("white")
      end

      it "returns true" do
        piece_cords = [2, 3]
        correct_color = test_game.correct_color?(piece_cords)
        expect(correct_color).to be(true)
      end
    end

    context "when the piece color is not the same as the current_player color" do
      before do
        test_board.board[4][6] = test_bishop
        allow(test_bishop).to receive(:color).and_return("black")
        allow(test_game.current_player).to receive(:color).and_return("white")
      end

      it "returns false" do
        piece_cords = [4, 6]
        correct_color = test_game.correct_color?(piece_cords)
        expect(correct_color).to be(false)
      end
    end
  end

  describe "stopping the game" do
    context "when the word is save" do
      it "returns true" do
        result = test_game.stopping_game?("save")
        expect(result).to be(true)
      end
    end

    context "when the word is quit" do
      it "returns true" do
        result = test_game.stopping_game?("quit")
        expect(result).to be(true)
      end
    end

    context "when the word is draw and half moves is over 99" do
      before do
        allow(test_board).to receive(:half_moves).and_return(100)
      end

      it "returns true" do
        result = test_game.stopping_game?("draw")
        expect(result).to be(true)
      end
    end

    context "when the word is draw and half moves is less than 99" do
      it "returns false" do
        result = test_game.stopping_game?("draw")
        expect(result).to be(false)
      end
    end

    context "when the word is not save, draw or quit" do
      it "returns false" do
        result = test_game.stopping_game?("ahhh")
        expect(result).to be(false)
      end
    end
  end
end
