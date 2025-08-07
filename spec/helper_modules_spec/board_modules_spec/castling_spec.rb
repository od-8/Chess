require_relative "../../../lib/helper_modules/board_modules/castling"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/rook"

RSpec.describe Castling do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8") }

  describe "#castle_king_side" do
    context "when castling king side" do
      let(:white_rook) { instance_double(Rook) }

      before do
        test_board.board[7][7] = white_rook
      end

      it "moves the rook" do
        piece_cords = [7, 4]
        test_board.castle_king_side(piece_cords)
        expect(test_board.board[7][5]).to eq(white_rook)
      end
    end
  end

  describe "#castle_queen_side" do
    context "when castling queen side" do
      let(:black_rook) { instance_double(Rook) }

      before do
        test_board.board[0][0] = black_rook
      end

      it "moves the rook" do
        piece_cords = [0, 4]
        test_board.castle_queen_side(piece_cords)
        expect(test_board.board[0][3]).to eq(black_rook)
      end
    end
  end
end
