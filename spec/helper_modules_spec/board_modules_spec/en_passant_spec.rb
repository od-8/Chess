require_relative "../../../lib/helper_modules/board_modules/en_passant"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/white_pawn"

RSpec.describe EnPassant do
  let(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }
  let(:white_pawn) { WhitePawn.new("pawn", "\u265f", "white") }

  describe "#set_passantable_status_to_false" do
    context "when passantable status and passantable cords are being changed" do
      before do
        test_board.set_passantable_status_to_false
      end

      it "updates passantable status to false" do
        expect(white_pawn.can_be_passanted).to be(false)
      end

      it "updates passantable_pawn_cords to nil" do
        expect(test_board.passantable_pawn_cords).to be_nil
      end
    end
  end

  describe "#set_passantable_status_to_true" do
    context "when passantable status and passantable cords are being changed" do
      before do
        piece_cords = [6, 4]
        move_cords = [4, 4]
        test_board.set_passantable_status_to_true(white_pawn, piece_cords, move_cords)
      end

      it "updates it passantable status to true" do
        expect(white_pawn.can_be_passanted).to be(true)
      end

      it "updates passantable_pawn_cords to move_cords" do
        expect(test_board.passantable_pawn_cords).to eq([4, 4])
      end
    end
  end

  describe "#remove_passant_pawn" do
    context "when piece.cords_of_passanted_pawn and dosnt return nil" do
      let(:dummy_piece) { BlackPawn.new("pawn", "\u2659", "black") }

      before do
        test_board.board[6][5] = dummy_piece
        piece_cords = [6, 4]
        move_cords = [5, 5]
        test_board.remove_passant_pawn(white_pawn, piece_cords, move_cords)
      end

      it "calls WhitePawn#cords_of_passanted_pawn" do
        expect(test_board.board[6][5]).to be_nil
      end
    end
  end
end
