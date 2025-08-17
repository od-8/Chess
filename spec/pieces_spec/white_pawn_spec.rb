require_relative "../../lib/pieces/white_pawn"

describe WhitePawn do
  subject(:test_pawn) { described_class.new("pawn", "\u265f", "white") }

  let(:board) { Array.new(8) { Array.new(8) } }

  describe "#legal_move" do
    let(:piece_cords) { [6, 4] }

    context "when move is valid" do
      let(:move_cords) { [4, 4] }

      it "returns true" do
        legal_move = test_pawn.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [5, 5] }

      it "returns false" do
        legal_move = test_pawn.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(false)
      end
    end
  end

  describe "#cords_of_passanted_pawn" do
    let(:piece_cords) { [4, 4] }

    context "when the pawn is en passanting" do
      let(:move_cords) { [3, 3] }

      it "returns [4, 3]" do
        passant_cords = test_pawn.cords_of_passanted_pawn(board, piece_cords, move_cords)
        expect(passant_cords).to eq([4, 3])
      end
    end

    context "when the pawn isnt en passanting" do
      let(:move_cords) { [3, 4] }

      it "returns nil" do
        passant_cords = test_pawn.cords_of_passanted_pawn(board, piece_cords, move_cords)
        expect(passant_cords).to be_nil
      end
    end
  end
end
