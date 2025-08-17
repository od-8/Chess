require_relative "../../lib/pieces/black_pawn"

describe BlackPawn do
  subject(:test_pawn) { described_class.new("pawn", "\u2659", "black") }

  let(:board) { Array.new(8) { Array.new(8) } }

  describe "#legal_move" do
    let(:piece_cords) { [1, 4] }

    context "when move is valid" do
      let(:move_cords) { [3, 4] }

      it "returns true" do
        legal_move = test_pawn.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [2, 3] }

      it "returns false" do
        legal_move = test_pawn.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(false)
      end
    end
  end

  describe "#cords_of_passanted_pawn" do
    let(:piece_cords) { [5, 5] }

    context "when the pawn is en passanting" do
      let(:move_cords) { [6, 6] }

      it "returns [4, 3]" do
        passant_cords = test_pawn.cords_of_passanted_pawn(board, piece_cords, move_cords)
        expect(passant_cords).to eq([5, 6])
      end
    end

    context "when the pawn isnt en passanting" do
      let(:move_cords) { [6, 5] }

      it "returns nil" do
        passant_cords = test_pawn.cords_of_passanted_pawn(board, piece_cords, move_cords)
        expect(passant_cords).to be_nil
      end
    end
  end
end
