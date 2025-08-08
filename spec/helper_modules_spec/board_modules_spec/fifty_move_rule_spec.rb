require_relative "../../../lib/helper_modules/board_modules/fifty_move_rule"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/knight"
require_relative "../../../lib/pieces/white_pawn"

RSpec.describe FiftyMoveRule do
  subject(:board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:dummy_knight) { instance_double(Knight) }
  let(:dummy_pawn) { instance_double(WhitePawn) }

  describe "#fifty_move_rule?" do
    context "when half_moves is equal to 100" do
      before do
        board.half_moves = 100
      end

      it "returns true" do
        over_fifty_moves = board.fifty_move_rule?
        expect(over_fifty_moves).to be(true)
      end
    end

    context "when half_moves i less than 100" do
      before do
        board.half_moves = 55
      end

      it "returns false" do
        over_fifty_moves = board.fifty_move_rule?
        expect(over_fifty_moves).to be(false)
      end
    end
  end

  describe "#update_half_moves" do
    before do
      allow(dummy_knight).to receive(:name).and_return("knight")
      board.half_moves = 31
    end

    context "when the piece is not a pawn and the move position is empty" do
      it "adds 1 to @half_moves" do
        move_cords = [4, 4]
        board.update_half_moves(dummy_knight, move_cords)
        expect(board.half_moves).to eq(32)
      end
    end

    context "when board at move_cords isnt empty" do
      before do
        board.board[4][4] = dummy_pawn
      end

      it "resets @half_moves back to 0" do
        move_cords = [4, 4]
        board.update_half_moves(dummy_knight, move_cords)
        expect(board.half_moves).to eq(0)
      end
    end

    context "when the piece is a pawn" do
      before do
        allow(dummy_pawn).to receive(:name).and_return("pawn")
      end

      it "resets @half_moves back to 0" do
        move_cords = [4, 4]
        board.update_half_moves(dummy_pawn, move_cords)
        expect(board.half_moves).to eq(0)
      end
    end
  end

  describe "#update_full_moves" do
    context "when its whites turn" do
      before do
        allow(dummy_pawn).to receive(:color).and_return("white")
        board.full_moves = 11
      end

      it "adds 1 to @full_moves" do
        board.update_full_moves(dummy_pawn)
        expect(board.full_moves).to eq(12)
      end
    end

    context "when its blacks turn" do
      before do
        allow(dummy_knight).to receive(:color).and_return("black")
        board.full_moves = 24
      end

      it "@full_moves stays the same" do
        board.update_full_moves(dummy_knight)
        expect(board.full_moves).to eq(24)
      end
    end
  end
end
