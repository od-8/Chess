require_relative "../../../lib/helper_modules/game_modules/get_coordinates"
require_relative "../../../lib/game"
require_relative "../../../lib/board"
require_relative "../../../lib/player"
require_relative "../../../lib/pieces/bishop"

# valid_coordinates?
# legal_coordinates?
# correct_color?
# draw_or_quit?
# to_cords

RSpec.describe GetCoordinates do
  subject(:test_game) do
    game = Game.new
    game.instance_variable_set(:@board, test_board)
    game.instance_variable_set(:@current_player, test_player)
    game
  end

  let(:test_player) { instance_double(Player) }
  let(:test_board) { Board.new("8/8/8/8/8/8/8/8") }

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

  describe "#draw_or_quit?" do
    context "when player inputs draw" do
      before do
        test_board.half_moves = 100
      end

      it "returns true" do
        cords = "draw"
        draw_or_quit = test_game.draw_or_quit?(cords)
        expect(draw_or_quit).to be(true)
      end
    end

    context "when player inputs quit" do
      it "returns true" do
        cords = "quit"
        draw_or_quit = test_game.draw_or_quit?(cords)
        expect(draw_or_quit).to be(true)
      end
    end

    context "when player inputs neither quit nor draw" do
      it "returns false" do
        cords = ""
        draw_or_quit = test_game.draw_or_quit?(cords)
        expect(draw_or_quit).to be(false)
      end
    end
  end
end
