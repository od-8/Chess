require_relative "../../../lib/helper_modules/board_modules/en_passant"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/bishop"

RSpec.describe EnPassant do
  let(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }
  let(:white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }

  describe "#update_passantable_status" do
    context "when a white pawn moves 2 forward" do
      before do
        test_board.board[1][3] = white_pawn
        test_board.update_passantable_status(white_pawn, [1, 3], [3, 3])
      end

      it "updates that pawns can_be_passanted status to true" do
        expect(white_pawn.can_be_passanted).to be(true)
      end

      it "updates passantable_pawn_cords to the move cords of that pawn" do
        expect(test_board.passantable_pawn_cords).to eq([3, 3])
      end
    end

    context "when the piece isnt a pawn" do
      let(:test_bishop) { instance_double(Bishop) }

      before do
        allow(test_bishop).to receive(:name).and_return("bishop")
      end

      it "returns nil" do
        result = test_board.update_passantable_status(test_bishop, [3, 7], [1, 5])
        expect(result).to be_nil
      end
    end
  end

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
      let(:dummy_piece) { BlackPawn.new("pawn", "\u265f", "black") }

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
