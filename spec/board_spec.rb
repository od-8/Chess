require_relative "../lib/board"
require_relative "../lib/pieces/white_pawn"
require_relative "../lib/pieces/black_pawn"
require_relative "../lib/pieces/knight"
require_relative "../lib/pieces/bishop"
require_relative "../lib/pieces/rook"
require_relative "../lib/pieces/queen"
require_relative "../lib/pieces/king"

describe Board do
  subject(:test_board) do
    board = described_class.new("8/8/8/8/8/8/8/8/")
    board.instance_variable_set(:@half_moves, 5)
    board.instance_variable_set(:@full_moves, 10)
    board
  end

  let(:test_knight) { instance_double(Knight) }
  let(:test_black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

  describe "#move" do
    context "when the piece is a white knight" do
      before do
        allow(test_knight).to receive_messages(name: "knight", color: "white")
        test_board.move(test_knight, [4, 3], [5, 2])
      end

      it "increments half moves" do
        expect(test_board.half_moves).to eq(6)
      end

      it "increments full moves" do
        expect(test_board.full_moves).to eq(11)
      end

      it "moves the knight to its new position" do
        expect(test_board.board[5][2]).to eq(test_knight)
      end
    end
  end

  context "when the piece is a black pawn and its moving 2 forward" do
    before do
      test_board.move(test_black_pawn, [1, 3], [3, 3])
    end

    it "updates the black pawns can_be_passanted to true" do
      expect(test_black_pawn.can_be_passanted).to be(true)
    end

    it "updates passantable_pawn_cords to the move cords of the pawn" do
      expect(test_board.passantable_pawn_cords).to eq([3, 3])
    end

    it "half moves resets to zero" do
      expect(test_board.half_moves).to eq(0)
    end

    it "full moves stays the same" do
      expect(test_board.full_moves).to eq(10)
    end

    it "moves the black pawn to its new position" do
      expect(test_board.board[3][3]).to eq(test_black_pawn)
    end
  end

  describe "#move_piece" do
    context "when the piece is a knight" do
      it "moves the knight to its new position" do
        test_board.move_piece(test_knight, [6, 7], [4, 6])
        expect(test_board.board[4][6]).to eq(test_knight)
      end
    end

    context "when the piece is a pawn" do
      it "moves the pawn to its new position" do
        test_board.move_piece(test_black_pawn, [4, 4], [5, 4])
        expect(test_board.board[5][4]).to eq(test_black_pawn)
      end
    end
  end
end

# Pieces
# - black pawn
# - white pawn
# - knight
# - rook
# - king
