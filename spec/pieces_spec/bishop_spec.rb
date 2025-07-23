require_relative "../../lib/pieces/bishop"

describe Bishop do
  subject(:test_bishop) { described_class.new("bishop", "\u265d", "white") }

  let(:board) { Array.new(8) { Array.new(8) } }
  let(:piece_cords) { [3, 3] }

  describe "#legal_move?" do
    context "when move is valid" do
      let(:move_cords) { [7, 7] }

      it "returns true" do
        legal_move = test_bishop.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [0, 1] }

      it "returns false" do
        legal_move = test_bishop.legal_move?(board, piece_cords, move_cords)

        expect(legal_move).to be(false)
      end
    end
  end
end
