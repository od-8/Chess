require_relative "../../../lib/helper_modules/board_modules/check"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/knight"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/rook"
require_relative "../../../lib/pieces/white_pawn"

RSpec.describe Check do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend Check } }

  describe "#king_is_in_check?" do
    let(:white_bishop) { instance_double(Bishop) }
    let(:king_cords) { [3, 3] }

    context "when black king is in check from a white bishop" do
      before do
        allow(white_bishop).to receive_messages(name: "bishop", color: "white")
        board[7][7] = white_bishop
      end

      it "returns true" do
        result = test_dummy.king_is_in_check?(board, king_cords, "black")
        expect(result).to be(true)
      end
    end

    context "when white king isnt in check" do
      it "returns false" do
        result = test_dummy.king_is_in_check?(board, king_cords, "white")
        expect(result).to be(false)
      end
    end
  end

  describe "#pawn_check?" do
    context "when a black king is in check from a white pawn" do
      let(:white_pawn) { instance_double(WhitePawn) }
      let(:king_cords) { [4, 6] }

      before do
        board[5][5] = white_pawn
        allow(white_pawn).to receive_messages(name: "pawn", color: "white")
      end

      it "returns true" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "black")
        expect(pawn_check).to be(true)
      end
    end

    context "when a white king is in check from a black pawn" do
      let(:black_pawn) { instance_double(BlackPawn) }
      let(:king_cords) { [6, 2] }

      before do
        board[5][3] = black_pawn
        allow(black_pawn).to receive_messages(name: "pawn", color: "black")
      end

      it "returns true" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "white")
        expect(pawn_check).to be(true)
      end
    end

    context "when black king isnt in check from a white pawn" do
      let(:king_cords) { [2, 1] }

      it "returns false" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "black")
        expect(pawn_check).to be(false)
      end
    end
  end

  describe "#knight_check?" do
    context "when white king is in check from a black knight" do
      let(:knight) { instance_double(Knight) }
      let(:king_cords) { [2, 5] }

      before do
        board[3][7] = knight
        allow(knight).to receive_messages(name: "knight", color: "black")
      end

      it "returns true" do
        knight_check = test_dummy.knight_check?(board, king_cords, "white")
        expect(knight_check).to be(true)
      end
    end

    context "when black king isnt in check from a white knight" do
      let(:king_cords) { [1, 6] }

      it "returns false" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "black")
        expect(pawn_check).to be(false)
      end
    end
  end

  describe "#diagonal_check?" do
    context "when black king is in check from a white queen" do
      let(:queen) { instance_double(Queen) }
      let(:king_cords) { [4, 5] }

      before do
        board[6][7] = queen
        allow(queen).to receive_messages(name: "queen", color: "white")
      end

      it "returns true" do
        queen_check = test_dummy.diagonal_check?(board, king_cords, "black")
        expect(queen_check).to be(true)
      end
    end

    context "when white king is in check from a black bishop" do
      let(:bishop) { instance_double(Bishop) }
      let(:king_cords) { [0, 0] }

      before do
        board[7][7] = bishop
        allow(bishop).to receive_messages(name: "bishop", color: "black")
      end

      it "returns true" do
        bishop_check = test_dummy.diagonal_check?(board, king_cords, "white")
        expect(bishop_check).to be(true)
      end
    end

    context "when black king isnt in check from a white queen or rook" do
      let(:king_cords) { [2, 1] }

      it "returns false" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "black")
        expect(pawn_check).to be(false)
      end
    end
  end

  describe "#inline_check?" do
    context "when black king is in check from a white rook" do
      let(:rook) { instance_double(Rook) }
      let(:king_cords) { [6, 3] }

      before do
        board[1][3] = rook
        allow(rook).to receive_messages(name: "rook", color: "white")
      end

      it "returns true" do
        rook_check = test_dummy.inline_check?(board, king_cords, "black")
        expect(rook_check).to be(true)
      end
    end

    context "when white king is in check from a black queen" do
      let(:queen) { instance_double(Queen) }
      let(:king_cords) { [2, 7] }

      before do
        board[2][0] = queen
        allow(queen).to receive_messages(name: "queen", color: "black")
      end

      it "returns true" do
        queen_check = test_dummy.inline_check?(board, king_cords, "white")
        expect(queen_check).to be(true)
      end
    end

    context "when black king isnt in check from a white queen or rook" do
      let(:king_cords) { [4, 0] }

      it "returns false" do
        pawn_check = test_dummy.pawn_check?(board, king_cords, "black")
        expect(pawn_check).to be(false)
      end
    end
  end
end
