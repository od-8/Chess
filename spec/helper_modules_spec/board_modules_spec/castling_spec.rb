require_relative "../../../lib/helper_modules/board_modules/castling"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/rook"

RSpec.describe Castling do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8") }

  let(:test_rook) { instance_double(Rook) }

  describe "#castling" do
    context "when castling king side" do
      before do
        test_board.board[0][7] = test_rook
        test_board.castling([0, 4], [0, 6])
      end

      it "moves the rook" do
        expect(test_board.board[0][5]).to eq(test_rook)
      end
    end

    context "when castling queen side" do
      before do
        test_board.board[7][0] = test_rook
        test_board.castling([7, 4], [7, 2])
      end

      it "moves the rook" do
        expect(test_board.board[7][3]).to eq(test_rook)
      end
    end

    context "when king isnt castling" do
      it "returns nil" do
        result = test_board.castling([0, 4], [1, 4])
        expect(result).to be_nil
      end
    end
  end

  describe "#castle_king_side" do
    context "when castling king side" do
      before do
        test_board.board[7][7] = test_rook
        test_board.castle_king_side([7, 4])
      end

      it "moves the rook" do
        expect(test_board.board[7][5]).to eq(test_rook)
      end
    end
  end

  describe "#castle_queen_side" do
    context "when castling queen side" do
      before do
        test_board.board[0][0] = test_rook
        test_board.castle_queen_side([0, 4])
      end

      it "moves the rook" do
        expect(test_board.board[0][3]).to eq(test_rook)
      end
    end
  end
end
