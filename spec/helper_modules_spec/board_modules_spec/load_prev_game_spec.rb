require_relative "../../../lib/helper_modules/board_modules/load_prev_game"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/rook"
require_relative "../../../lib/pieces/king"

RSpec.describe LoadPreviousGame do # rubocop:disable RSpec/SpecFilePathFormat
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:previous_boards) do
    [["rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq 0 1 "],
     ["rnbqkbnr/ppp1pppp/8/3p4/3P4/8/PPP1PPPP/RNBQKBNR b KQkq 0 1"]]
  end

  describe "#udpate_board_info" do
    context "when loading a previous game" do
      before do
        test_board.board[3][3] = BlackPawn.new("pawn", "\u2659", "black")
        test_board.update_board_info(previous_boards, [3, 3], "KQkq", "2", "10")
      end

      it "updates passantable_pawn_cords" do
        expect(test_board.passantable_pawn_cords).to eq([3, 3])
      end

      it "updates pawns can be passanted status" do
        black_pawn = test_board.board[3][3]
        expect(black_pawn.can_be_passanted).to be(true)
      end

      it "updates half_moves" do
        expect(test_board.half_moves).to eq(2)
      end

      it "updates full_moves" do
        expect(test_board.full_moves).to eq(10)
      end
    end
  end

  describe "#seperate_castling_chars" do
    context "when castling on both sides is possible" do
      it "returns and array containing the white side and black side castling positions" do
        seperate_arr = test_board.seperate_castling_chars("KQkq")
        expect(seperate_arr).to eq(%w[KQ kq])
      end
    end
  end

  describe "#update_white_castling_vars" do
    context "when the king can only castle king side" do
      it "updates rook has_moved status to true" do
        test_board.board[7][7] = Rook.new("rook", "\u265c", "white")
        test_board.board[4][5] = Rook.new("rook", "\u265c", "white")

        rook = test_board.board[4][5]
        test_board.update_white_castling_vars("K")

        expect(rook.has_moved).to be(true)
      end

      it "updates king has_moved status to true" do
        test_board.board[7][4] = King.new("king", "\u265a", "white")

        king = test_board.board[7][4]
        test_board.update_white_castling_vars("")

        expect(king.has_moved).to be(true)
      end
    end
  end

  describe "#update_black_castling_vars" do
    context "when the king can only castle queen side" do
      it "updates rook has_moved status to true" do
        test_board.board[0][0] = Rook.new("rook", "\u2656", "black")
        test_board.board[2][3] = Rook.new("rook", "\u2656", "black")

        rook = test_board.board[2][3]
        test_board.update_black_castling_vars("q")

        expect(rook.has_moved).to be(true)
      end

      it "updates king has_moved status to true" do
        test_board.board[0][4] = King.new("king", "\u2654", "black")

        king = test_board.board[0][4]
        test_board.update_black_castling_vars("")

        expect(king.has_moved).to be(true)
      end
    end
  end
end
