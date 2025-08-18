require_relative "../../../lib/helper_modules/board_modules/checkmate"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/king"

RSpec.describe Checkmate do
  subject(:test_board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:white_king) { King.new("king", "\u2654", "white") }
  let(:black_queen) { Queen.new("queen", "\u265b", "black") }
  let(:white_pawn_one) { WhitePawn.new("pawn", "\u2659", "white") }
  let(:white_pawn_two) { WhitePawn.new("pawn", "\u2659", "white") }

  describe "#in_checkmate?" do
    context "when in checkmate" do
      before do
        test_board.board[7][7] = white_king
        test_board.board[7][5] = black_queen
        test_board.board[6][7] = white_pawn_one
        test_board.board[6][6] = white_pawn_two
      end

      it "returns true" do
        result = test_board.in_checkmate?("white")
        expect(result).to be(true)
      end
    end

    context "when not in checkmate" do
      before do
        test_board.board[3][3] = white_king
      end

      it "returns false" do
        result = test_board.in_checkmate?("white")
        expect(result).to be(false)
      end
    end
  end

  describe "#stop_check_positions" do
    context "when there are moves that can stop checkmate" do
      let(:white_bishop) { Bishop.new("bishop", "\u2657", "white") }

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

  describe "#move_places" do
    context "when the white king has a move" do
      before do
        test_board.board[7][7] = white_king
        test_board.board[7][6] = black_queen
      end

      it "returns the kings only legal move" do
        possible_moves = white_king.possible_king_moves(7, 7)
        legal_moves = test_board.move_places([7, 7], possible_moves, "white")
        expect(legal_moves).to eq([[7, 6]])
      end
    end

    context "when the white king has no moves" do
      before do
        test_board.board[7][7] = white_king
        test_board.board[6][7] = white_pawn_one
        test_board.board[7][5] = black_queen
      end

      it "returns an empty array" do
        possible_moves = white_king.possible_king_moves(7, 7)
        legal_moves = test_board.move_places([7, 7], possible_moves, "white")
        expect(legal_moves).to eq([])
      end
    end

    context "when the white bishop has all its moves" do
      let(:white_bishop) { Bishop.new("bishop", "\u2657", "white") }

      before do
        test_board.board[0][4] = white_king
        test_board.board[3][3] = white_bishop
      end

      it "returns all the bishops legal moves" do
        possible_moves = white_bishop.possible_diagonal_moves(test_board.board, [3, 3], "white")
        legal_moves = test_board.move_places([3, 3], possible_moves, "white")
        expect(legal_moves).to eq([[4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [6, 6], [7, 7], [2, 2], [1, 1], [0, 0], 
                                   [2, 4], [1, 5], [0, 6]])
      end
    end
  end
end
