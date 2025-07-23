require_relative "../../lib/pieces/knight"

describe Knight do
  subject(:test_knight) { described_class.new("knight", "\u265e", "white") }

  let(:board) { Array.new(8) { Array.new(8) } }
  let(:piece_cords) { [5, 5] }

  describe "#legal_move?" do
    context "when move is valid" do
      let(:move_cords) { [7, 6] }

      it "returns true" do
        legal_move = test_knight.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [7, 7] }

      it "returns false" do
        legal_move = test_knight.legal_move?(board, piece_cords, move_cords)

        expect(legal_move).to be(false)
      end
    end
  end
end
