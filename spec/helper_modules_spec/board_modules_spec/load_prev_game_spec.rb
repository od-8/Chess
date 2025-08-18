require_relative "../../../lib/helper_modules/board_modules/load_prev_game"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/rook"
require_relative "../../../lib/pieces/king"

RSpec.describe LoadPreviousGame do # rubocop:disable RSpec/SpecFilePathFormat
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:test_white_king) { King.new("king", "\u2654", "white") }
  let(:test_black_king) { King.new("king", "\u265a", "black") }
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

  describe "#update_castling_rights" do
    let(:test_white_rook) { Rook.new("rook", "\u2656", "white") }
    let(:test_black_rook) { Rook.new("rook", "\u265c", "black") }

    context "when castling king side is availabe for white and there are not castling possibilites for black" do
      before do
        test_board.board[4][3] = test_white_rook
        test_board.board[5][2] = test_black_king
        test_board.update_castling_rights("K")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_white_rook.has_moved).to be(true)
      end

      it "updates the black kings has_moved status to true" do
        expect(test_black_king.has_moved).to be(true)
      end
    end

    context "when castling queen side is available for white and castling king side is available for black" do
      before do
        test_board.board[2][2] = test_white_rook
        test_board.board[7][6] = test_black_rook
        test_board.update_castling_rights("Qk")
      end

      it "updates blacks queen side rooks has_moved status to true" do
        expect(test_white_rook.has_moved).to be(true)
      end

      it "updates whites king side rooks has_moved status to true" do
        expect(test_black_rook.has_moved).to be(true)
      end
    end

    context "when all castling is availabe" do
      it "returns nil" do
        result = test_board.update_castling_rights("KQkq")
        expect(result).to be_nil
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

    context "when castling is not possible for either side" do
      it "returns an array of two empty strings" do
        seperate_arr = test_board.seperate_castling_chars("")
        expect(seperate_arr).to eq(["", ""])
      end
    end
  end

  describe "#update_white_castling_vars" do
    let(:test_white_rook) { Rook.new("rook", "\u2656", "white") }

    context "when the king can castle both sides" do
      it "returns nil" do
        result = test_board.update_white_castling_vars("KQ")
        expect(result).to be_nil
      end
    end

    context "when the king can only castle king side" do
      before do
        test_board.board[6][0] = test_white_rook
        test_board.update_white_castling_vars("K")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_white_rook.has_moved).to be(true)
      end
    end

    context "when the king can not castle on either side" do
      before do
        test_board.board[7][4] = test_white_king
        test_board.update_white_castling_vars("")
      end

      it "updates the kings has_moved status to true" do
        expect(test_white_king.has_moved).to be(true)
      end
    end
  end

  describe "#update_black_castling_vars" do
    let(:test_black_rook) { Rook.new("rook", "\u265c", "black") }

    context "when the king can castle both sides" do
      it "returns nil" do
        result = test_board.update_black_castling_vars("kq")
        expect(result).to be_nil
      end
    end

    context "when the king can only castle queen side" do
      before do
        test_board.board[4][0] = test_black_rook
        test_board.update_black_castling_vars("q")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_black_rook.has_moved).to be(true)
      end
    end

    context "when the king can not castle on either side" do
      before do
        test_board.board[0][4] = test_black_king
        test_board.update_black_castling_vars("")
      end

      it "updates the kings has_moved status to true" do
        expect(test_black_king.has_moved).to be(true)
      end
    end
  end

  describe "#update_white_rook" do
    let(:test_white_rook) { Rook.new("rook", "\u2656", "white") }

    context "when castling king side is legal" do
      before do
        test_board.board[4][2] = test_white_rook
        test_board.update_white_rook("K")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_white_rook.has_moved).to be(true)
      end
    end

    context "when castling queen side is legal" do
      before do
        test_board.board[6][5] = test_white_rook
        test_board.update_white_rook("Q")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_white_rook.has_moved).to be(true)
      end
    end
  end

  describe "#update_black_rook" do
    let(:test_black_rook) { Rook.new("rook", "\u265c", "black") }

    context "when castling king side is legal" do
      before do
        test_board.board[4][2] = test_black_rook
        test_board.update_black_rook("k")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_black_rook.has_moved).to be(true)
      end
    end

    context "when castling queen side is legal" do
      before do
        test_board.board[6][5] = test_black_rook
        test_board.update_black_rook("q")
      end

      it "updates the moved rooks has_moved status to true" do
        expect(test_black_rook.has_moved).to be(true)
      end
    end
  end

  describe "#find_rook" do
    let(:moved_rook) { Rook.new("rook", "\u2656", "white") }

    context "when finding a white rook" do
      before do
        test_board.board[7][6] = moved_rook
        test_board.board[7][7] = Rook.new("rook", "\u2656", "white")
      end

      it "returns the coordinates of the white rook" do
        rook_cords = test_board.find_rook("white", [7, 7])
        expect(rook_cords).to eq(moved_rook)
      end
    end

    context "when finding a black rook" do
      let(:moved_rook) { Rook.new("rook", "\u265c", "black") }

      before do
        test_board.board[1][0] = moved_rook
        test_board.board[0][0] = Rook.new("rook", "\u265c", "black")
      end

      it "returns the coordinates of the black rook" do
        rook_cords = test_board.find_rook("black", [0, 0])
        expect(rook_cords).to eq(moved_rook)
      end
    end
  end
end
