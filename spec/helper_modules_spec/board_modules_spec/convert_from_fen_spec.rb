require_relative "../../../lib/helper_modules/board_modules/convert_from_fen"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/king"
require_relative "../../../lib/pieces/knight"
require_relative "../../../lib/pieces/black_pawn"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/rook"

RSpec.describe ConvertFromFen do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8") }

  describe "#convert_board_from_fen" do
    context "when the board is empty" do
      it "returns a 2d array" do
        new_board = test_board.convert_board_from_fen("8/8/8/8/8/8/8/8/")
        expect(new_board).to eq(Array.new(8) { Array.new(8) })
      end
    end

    context "when the board isnt empty" do
      it "returns an array" do
        new_board = test_board.convert_board_from_fen("3K4/8/8/4r3/8/8/8/8/")
        expect(new_board).to be_an_instance_of(Array)
      end

      it "contains a king" do
        new_board = test_board.convert_board_from_fen("3K4/8/8/4r3/8/8/8/8/")
        expect(new_board[0][3]).to be_an_instance_of(King)
      end

      it "contains a rook" do
        new_board = test_board.convert_board_from_fen("3K4/8/8/4r3/8/8/8/8/")
        expect(new_board[3][4]).to be_an_instance_of(Rook)
      end
    end
  end

  describe "#convert_nums_to_dots" do
    context "when the board is empty" do
      it "returns a string with 8 sets of 8 dots seperated by a /" do
        fen_str = test_board.convert_nums_to_dots("8/8/8/8/8/8/8/8/")
        expect(fen_str).to eq("......../......../......../......../......../......../......../......../")
      end
    end

    context "when the board isnt emtpy" do
      it "returns a string of dots with some letter" do
        fen_str = test_board.convert_nums_to_dots("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
        expect(fen_str).to eq("rnbqkbnr/pppppppp/......../......../......../......../PPPPPPPP/RNBQKBNR/")
      end
    end
  end

  describe "#create_new_board" do
    context "when creating a new empty board" do
      it "returns a 2d array" do
        new_board =
          test_board.create_new_board("......../......../......../......../......../......../......../......../")

        expect(new_board).to eq(Array.new(8) { Array.new(8) })
      end
    end

    context "when creating a new board that isnt empty" do
      it "returns an array" do
        new_board =
          test_board.create_new_board("...k..../....N.../......../......../......../......../......../......../")

        expect(new_board).to be_an_instance_of(Array)
      end

      it "creates a knight and adds it to the board" do
        new_board =
          test_board.create_new_board("...k..../....N.../......../......../......../......../......../......../")

        expect(new_board[1][4]).to be_an_instance_of(Knight)
      end

      it "creates the kings and add them to the board" do
        new_board =
          test_board.create_new_board("...k..../....N.../......../......../......../......../......../......../")

        expect(new_board[0][3]).to be_an_instance_of(King)
      end
    end
  end

  describe "#convert_piece" do
    context "when the piece is a white queen" do
      it "returns a new queen" do
        piece = test_board.convert_piece("Q")
        expect(piece).to be_an_instance_of(Queen)
      end

      it "updates the queens color to white" do
        piece = test_board.convert_piece("Q")
        expect(piece.color).to eq("white")
      end
    end

    context "when the piece is a black knight" do
      it "returns a new knight" do
        piece = test_board.convert_piece("n")
        expect(piece).to be_an_instance_of(Knight)
      end

      it "updates the knight color to black" do
        piece = test_board.convert_piece("n")
        expect(piece.color).to eq("black")
      end
    end
  end

  describe "#handle_white_piece" do
    context "when the piece is a bishop" do
      it "returns a new bishop" do
        piece = test_board.handle_white_piece("B")
        expect(piece).to be_an_instance_of(Bishop)
      end
    end

    context "when the piece is a king" do
      it "returns a new king" do
        piece = test_board.handle_white_piece("K")
        expect(piece).to be_an_instance_of(King)
      end
    end
  end

  describe "#handle_black_piece" do
    context "when the piece is a pawn" do
      it "returns a new pawn" do
        piece = test_board.handle_black_piece("p")
        expect(piece).to be_an_instance_of(BlackPawn)
      end
    end

    context "when the piece is a rook" do
      it "returns a new rook" do
        piece = test_board.handle_black_piece("r")
        expect(piece).to be_an_instance_of(Rook)
      end
    end
  end
end
