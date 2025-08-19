require_relative "../../../lib/helper_modules/board_modules/convert_to_fen"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/knight"
require_relative "../../../lib/pieces/black_pawn"

RSpec.describe ConvertToFen do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:test_white_king) { King.new("king", "\u2654", "white") }
  let(:test_white_rook) { Rook.new("rook", "\u2656", "white") }
  let(:test_black_king) { King.new("king", "\u265a", "black") }
  let(:test_black_rook) { Rook.new("rook", "\u265c", "black") }

  describe "#convert_to_fen" do
    context "when its white turn and both sides can castle both sides" do
      before do
        test_board.board[7][0] = test_white_rook
        test_board.board[7][4] = test_white_king
        test_board.board[7][7] = test_white_rook

        test_board.board[0][0] = test_black_rook
        test_board.board[0][4] = test_black_king
        test_board.board[0][7] = test_black_rook

        test_board.half_moves = 14
        test_board.full_moves = 6
      end

      it "returns a string containg the game info" do
        string = test_board.convert_to_fen(test_board.board, "white")
        expect(string).to eq("r3k2r/8/8/8/8/8/8/R3K2R w KQkq 14 6")
      end
    end

    context "when its blacks turn and neither side can caslte" do
      before do
        test_board.board[7][4] = test_white_king
        test_board.board[0][4] = test_black_king

        test_board.half_moves = 7
        test_board.full_moves = 9
      end

      it "returns a string containing the game info" do
        string = test_board.convert_to_fen(test_board.board, "black")
        expect(string).to eq("4k3/8/8/8/8/8/8/4K3 b - 7 9")
      end
    end
  end

  describe "#convert_board_to_fen" do
    context "when converting an empty board" do
      it "returns an empty board in fen notation" do
        fen_board = test_board.convert_board_to_fen(test_board.board)
        expect(fen_board).to eq("8/8/8/8/8/8/8/8")
      end
    end

    context "when converting a board with pieces to fen" do
      before do
        test_board.board[7][4] = test_white_king
        test_board.board[0][4] = test_black_king
      end

      it "returns an empty board in fen notation" do
        fen_board = test_board.convert_board_to_fen(test_board.board)
        expect(fen_board).to eq("4k3/8/8/8/8/8/8/4K3")
      end
    end
  end

  describe "#convert_pieces_to_fen" do
    context "when converting an empty board" do
      it "returns the board as fen" do
        string = test_board.convert_pieces_to_fen(test_board.board)
        expect(string).to eq("......../......../......../......../......../......../......../........")
      end
    end

    context "when converting a board with pieces" do
      before do
        test_board.board[7][4] = test_white_king
        test_board.board[7][3] = test_white_rook
        test_board.board[7][7] = test_black_king
        test_board.board[6][0] = test_black_rook
      end

      it "returns the board as fen" do
        string = test_board.convert_pieces_to_fen(test_board.board)
        expect(string).to eq("......../......../......../......../......../......../r......./...RK..k")
      end
    end
  end

  describe "#convert_piece_to_fen" do
    context "when the piece is a white knight" do
      let(:test_white_knight) { Knight.new("knight", "\u2658", "white") }

      it "returns N" do
        letter = test_board.convert_piece_to_fen(test_white_knight)
        expect(letter).to eq("N")
      end
    end

    context "when the piece is a black knight" do
      let(:test_black_knight) { Knight.new("knight", "\u265e", "black") }

      it "returns n" do
        letter = test_board.convert_piece_to_fen(test_black_knight)
        expect(letter).to eq("n")
      end
    end

    context "when the piece is a white bishop" do
      let(:test_white_bishop) { Bishop.new("bishop", "\u2657", "white") }

      it "returns B" do
        letter = test_board.convert_piece_to_fen(test_white_bishop)
        expect(letter).to eq("B")
      end
    end

    context "when the piece is a black pawn" do
      let(:test_black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

      it "returns p" do
        letter = test_board.convert_piece_to_fen(test_black_pawn)
        expect(letter).to eq("p")
      end
    end
  end

  describe "#convert_to_fen_arr" do
    context "when converting an empty board" do
      it "returns the board as fen" do
        string =
          test_board.convert_to_fen_arr("......../......../......../......../......../......../......../......../")

        expect(string).to eq([8, "/", 8, "/", 8, "/", 8, "/", 8, "/", 8, "/", 8, "/", 8, "/"])
      end
    end

    context "when converting a board with some pieces" do
      it "returns the board as fen" do
        string =
          test_board.convert_to_fen_arr("...k..../...n..../......../......../......b./......R./.Q....../......K../")

        expect(string).to eq([3, "k", 4, "/", 3, "n", 4, "/", 8, "/", 8, "/", 6, "b", 1, "/", 6, "R", 1, "/", 1, "Q", 6,
                              "/", 6, "K", 2, "/"])
      end
    end
  end

  describe "#fen_move_counts" do
    context "when half moves is 10 and full moves is 5" do
      before do
        test_board.half_moves = 10
        test_board.full_moves = 5
      end

      it "returns a string containing the number of half moves and full moves" do
        string = test_board.fen_move_counts
        expect(string).to eq(" 10 5")
      end
    end
  end

  describe "#fen_castling" do
    context "when white can castle king side and queen side and where black can only castle king side" do
      before do
        test_board.board[7][0] = test_white_rook
        test_board.board[7][4] = test_white_king
        test_board.board[7][7] = test_white_rook

        test_board.board[0][4] = test_black_king
        test_board.board[0][7] = test_black_rook
      end

      it "returns a string containing the castling rights for each side" do
        string = test_board.fen_castling
        expect(string).to eq("KQk")
      end
    end
  end

  describe "#white_castling_moves" do
    context "when the king can castle king and queen side" do
      before do
        test_board.board[7][0] = test_black_rook
        test_board.board[7][4] = test_black_king
        test_board.board[7][7] = test_black_rook
      end

      it "returns a string containing kq" do
        string = test_board.white_castling_moves
        expect(string).to eq("KQ")
      end
    end

    context "when the king can only castle king side" do
      before do
        test_board.board[7][4] = test_white_king
        test_board.board[7][7] = test_white_rook
      end

      it "returns a string containing k" do
        string = test_board.white_castling_moves
        expect(string).to eq("K")
      end
    end

    context "when the king has moved" do
      before do
        test_white_king.has_moved = true
        test_board.board[0][4] = test_white_king
      end

      it "returns and empty string" do
        string = test_board.white_castling_moves
        expect(string).to eq("")
      end
    end
  end

  describe "#black_castling_moves" do
    context "when the king can castle king and queen side" do
      before do
        test_board.board[0][0] = test_black_rook
        test_board.board[0][4] = test_black_king
        test_board.board[0][7] = test_black_rook
      end

      it "returns a string containing kq" do
        string = test_board.black_castling_moves
        expect(string).to eq("kq")
      end
    end

    context "when the king can only castle queen side" do
      before do
        test_board.board[0][0] = test_black_rook
        test_board.board[0][4] = test_black_king
      end

      it "returns a string containing q" do
        string = test_board.black_castling_moves
        expect(string).to eq("q")
      end
    end

    context "when the king has moved" do
      before do
        test_black_king.has_moved = true
        test_board.board[0][4] = test_black_king
      end

      it "returns and empty string" do
        string = test_board.black_castling_moves
        expect(string).to eq("")
      end
    end
  end

  describe "#legal_castling?" do
    context "when there is a rook at the passed coordinates" do
      before do
        test_board.board[7][0] = test_white_rook
      end

      it "returns true" do
        result = test_board.legal_castling?(7, 0)
        expect(result).to be(true)
      end
    end

    context "when there isnt a rook at the passed coordinates" do
      it "returns false" do
        result = test_board.legal_castling?(7, 7)
        expect(result).to be(false)
      end
    end
  end
end
