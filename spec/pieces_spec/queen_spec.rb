require_relative "../../lib/pieces/queen"

describe Queen do
  subject(:test_queen) { described_class.new("queen", "\u265b", "white") }

  let(:board) { Array.new(8) { Array.new(8) } }
  let(:piece_cords) { [6, 3] }

  describe "#legal_move?" do
    context "when move is valid" do
      let(:move_cords) { [2, 7] }

      it "returns true" do
        legal_move = test_queen.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [7, 5] }

      it "returns false" do
        legal_move = test_queen.legal_move?(board, piece_cords, move_cords)

        expect(legal_move).to be(false)
      end
    end
  end
end
