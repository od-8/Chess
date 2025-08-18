require_relative "../../../lib/helper_modules/board_modules/insufficient_material"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/knight"

RSpec.describe InsufficientMaterial do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:test_white_king) { King.new("king", "\u2654", "white") }
  let(:test_black_king) { King.new("king", "\u265a", "black") }
  let(:test_bishop) { Bishop.new("bishop", "\u2657", "white") }
  let(:test_knight) { Knight.new("knight", "\u265e", "black") }

  describe "#insufficent_material?" do
    context "when neither side has enough material" do
      before do
        test_board.board[3][5] = test_white_king
        test_board.board[4][6] = test_bishop
        test_board.board[6][5] = test_black_king
        test_board.board[1][2] = test_knight
      end

      it "returns true" do
        result = test_board.insufficient_material?
        expect(result).to be(true)
      end
    end

    context "when black doesnt have enough material" do
      let(:test_white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }

      before do
        test_board.board[3][5] = test_white_king
        test_board.board[4][6] = test_bishop
        test_board.board[2][7] = test_white_pawn
        test_board.board[6][5] = test_black_king
        test_board.board[1][2] = test_knight
      end

      it "returns false" do
        result = test_board.insufficient_material?
        expect(result).to be(false)
      end
    end

    context "when white doesnt have enough material" do
      let(:test_black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

      before do
        test_board.board[3][5] = test_white_king
        test_board.board[4][6] = test_bishop
        test_board.board[6][5] = test_black_king
        test_board.board[1][2] = test_knight
        test_board.board[3][5] = test_black_pawn
      end

      it "returns false" do
        result = test_board.insufficient_material?
        expect(result).to be(false)
      end
    end
  end

  describe "#insufficient_color_material?" do
    context "when there is a white king and a white bishop" do
      before do
        test_board.board[5][6] = test_white_king
        test_board.board[3][4] = test_bishop
      end

      it "returns true" do
        result = test_board.insufficient_color_material?("white")
        expect(result).to be(true)
      end
    end

    context "when there is a black king, 1 black bishop and a 1 black knight" do
      let(:test_bishop) { Bishop.new("bishop", "\u265d", "black") }

      before do
        test_board.board[4][7] = test_black_king
        test_board.board[3][0] = test_bishop
        test_board.board[1][7] = test_knight
      end

      it "returns false" do
        result = test_board.insufficient_color_material?("black")
        expect(result).to be(false)
      end
    end
  end

  describe "#not_enough_material" do
    context "when there is 1 white king and 1 white bishop" do
      it "returns true" do
        insufficient_material = test_board.not_enough_material?([test_bishop], [], [test_white_king])
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 black kings and 2 black knights" do
      let(:test_knight_two) { Knight.new("knight", "\u265e", "black") }

      it "returns true" do
        knights = [test_knight, test_knight_two]
        insufficient_material = test_board.not_enough_material?([], knights, [test_black_king])
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 white king" do
      it "returns true" do
        insufficient_material = test_board.not_enough_material?([], [], [test_white_king])
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 black king, 1 black bishop and 1 black knight" do
      let(:test_black_bishop) { Bishop.new("bishop", "\u265d", "black") }

      it "returns false" do
        bishops = [test_black_bishop, test_knight]
        insufficient_material = test_board.not_enough_material?(bishops, [], [test_black_king])
        expect(insufficient_material).to be(false)
      end
    end
  end
end
