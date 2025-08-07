require_relative "../../../lib/helper_modules/board_modules/checkmate"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/king"

RSpec.describe Checkmate do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  describe "#Checkmate" do
    let(:white_king) { King.new("king", "\u265a", "white") }
    let(:black_queen) { Queen.new("queen", "\u2655", "black") }
    let(:white_pawn_one) { WhitePawn.new("pawn", "\u265f", "white") }
    let(:white_pawn_two) { WhitePawn.new("pawn", "\u265f", "white") }

    context "when there are moves that can stop checkmate" do
      let(:white_bishop) { Bishop.new("bishop", "\u265d", "white") }

      before do
        test_board.board[7][7] = white_king
        test_board.board[7][5] = black_queen
        test_board.board[6][7] = white_pawn_one
        test_board.board[6][6] = white_pawn_two
        test_board.board[5][4] = white_bishop
      end

      it "returns an array with those moves" do
        stop_check_positions = test_board.stop_check_positions("white")
        expect(stop_check_positions).to eq([[7, 6]])
      end
    end

    context "when there are no moves that can stop checkmate" do
      before do
        test_board.board[7][7] = white_king
        test_board.board[7][5] = black_queen
        test_board.board[6][7] = white_pawn_one
        test_board.board[6][6] = white_pawn_two
      end

      it "returns an empty array" do
        stop_check_positions = test_board.stop_check_positions("white")
        expect(stop_check_positions).to eq([])
      end
    end
  end
end
