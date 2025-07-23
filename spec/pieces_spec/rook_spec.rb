require_relative "../../lib/pieces/rook"

describe Rook do
  subject(:test_rook) { described_class.new("rook", "\u2656", "black") }

  let(:board) { Array.new(8) { Array.new(8) } }
  let(:piece_cords) { [4, 4] }

  describe "#legal_move?" do
    context "when move is valid" do
      let(:move_cords) { [4, 1] }

      it "returns true" do
        legal_move = test_rook.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [6, 2] }

      it "returns false" do
        legal_move = test_rook.legal_move?(board, piece_cords, move_cords)

        expect(legal_move).to be(false)
      end
    end
  end
end
