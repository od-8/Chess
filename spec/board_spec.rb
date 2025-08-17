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

  let(:test_knight) { Knight.new("knight", "\u265e", "black") }
  let(:test_black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }
  let(:test_king) { King.new("king", "\u265a", "black") }
  let(:test_rook) { Rook.new("rook", "\u2656", "white") }

  describe "#move" do
    context "when the piece is a white knight" do
      before do
        test_board.move(test_knight, [4, 3], [5, 2])
      end

      it "increments half moves" do
        expect(test_board.half_moves).to eq(6)
      end

      it "full moves stays the same" do
        expect(test_board.full_moves).to eq(10)
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

  describe "#handle_piece" do
    context "when the piece is a knight" do
      it "returns the piece" do
        result = test_board.handle_piece(test_knight, [4, 5], [3, 7])
        expect(result).to eq(test_knight)
      end
    end

    context "when the piece is a rook" do
      it "updates the rooks has_moved status to true" do
        test_board.handle_piece(test_rook, [4, 1], [4, 7])
        expect(test_rook.has_moved).to be(true)
      end

      it "returns the rook" do
        result = test_board.handle_piece(test_rook, [2, 3], [6, 3])
        expect(result).to eq(test_rook)
      end
    end

    context "when the pice is a king and the king is moving 1 forward" do
      it "updates the kings has_moved status to true" do
        test_board.handle_piece(test_king, [0, 4], [1, 4])
        expect(test_king.has_moved).to be(true)
      end

      it "returns the king" do
        result = test_board.handle_piece(test_king, [0, 4], [1, 4])
        expect(result).to eq(test_king)
      end
    end

    context "when the piece is a black pawn and its moving 1 forward" do
      it "returns the pawn" do
        result = test_board.handle_piece(test_black_pawn, [0, 4], [1, 4])
        expect(result).to eq(test_black_pawn)
      end
    end
  end

  describe "#handle_pawn" do
    context "when the piece isnt a pawn" do
      it "returns that piece" do
        result = test_board.handle_pawn(test_knight, [1, 1], [2, 3])
        expect(result).to eq(test_knight)
      end
    end

    context "when the pawn is moving 1 forward" do
      it "returns the pawn" do
        result = test_board.handle_pawn(test_black_pawn, [1, 1], [2, 1])
        expect(result).to eq(test_black_pawn)
      end
    end

    context "when the pawn is moving 2 forwad" do
      it "updates boards passantable_pawn_cords to the pawns move cords" do
        test_board.handle_pawn(test_black_pawn, [1, 1], [3, 1])
        expect(test_board.passantable_pawn_cords).to eq([3, 1])
      end

      it "updates the pawn can_be_passanted status to true" do
        test_board.handle_pawn(test_black_pawn, [1, 1], [3, 1])
        expect(test_black_pawn.can_be_passanted).to be(true)
      end

      it "returns the pawn" do
        result = test_board.handle_pawn(test_black_pawn, [1, 1], [3, 1])
        expect(result).to eq(test_black_pawn)
      end
    end

    context "when the pawn is en passanting" do
      let(:test_white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }

      before do
        test_board.board[4][3] = test_white_pawn
        test_board.passantable_pawn_cords = [4, 3]
        test_white_pawn.can_be_passanted = true
      end

      it "sets passantable_pawn_cords to nil" do
        test_board.handle_pawn(test_black_pawn, [4, 2], [5, 3])
        expect(test_board.passantable_pawn_cords).to be_nil
      end

      it "sets the passantable pawns can_be_passanted status to false" do
        test_board.handle_pawn(test_black_pawn, [4, 2], [5, 3])
        expect(test_white_pawn.can_be_passanted).to be(false)
      end

      it "removes the passant pawn from the board" do
        test_board.handle_pawn(test_black_pawn, [4, 2], [5, 3])
        expect(test_board.board[4][3]).to be_nil
      end

      it "returns the pawn" do
        result = test_board.handle_pawn(test_black_pawn, [4, 2], [5, 3])
        expect(result).to eq(test_black_pawn)
      end
    end

    context "when the pawn is promoting to a queen" do
      before do
        allow(test_board).to receive(:puts) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:gets).and_return("queen") # rubocop:disable RSpec/SubjectStub
      end

      it "returns a new instance of Queen" do
        result = test_board.handle_pawn(test_black_pawn, [6, 0], [7, 0])
        expect(result).to be_an_instance_of(Queen)
      end
    end
  end

  describe "#unnocupied_square?" do
    context "when the square is unnocupied" do
      it "returns true" do
        result = test_board.unnocupied_square?(test_rook, [3, 3])
        expect(result).to be(true)
      end
    end

    context "when the square is occupied by an opposite color piece" do
      it "returns true" do
        test_board.board[2][7] = test_rook
        result = test_board.unnocupied_square?(test_knight, [2, 7])
        expect(result).to be(true)
      end
    end

    context "when the square is occupied by a piece of the same color" do
      it "returns false" do
        test_board.board[4][1] = test_knight
        result = test_board.unnocupied_square?(test_black_pawn, [4, 1])
        expect(result).to be(false)
      end
    end
  end

  describe "#clone_and_update" do
    context "when copying the board and then moving a piece on the new board" do
      it "returns a copy of the board with the piece is the new positon" do
        test_board.board[0][4] = test_king
        clone_board = test_board.clone_and_update([0, 4], [0, 5])
        expect(clone_board[0][5]).to be_an_instance_of(King)
      end
    end
  end

  describe "#find_king_coordinates" do
    context "when there is a black king on the board" do
      it "returns the cords of that king" do
        test_board.board[3][3] = test_king
        result = test_board.find_king_coordinates(test_board.board, "black")
        expect(result).to eq([3, 3])
      end
    end

    context "when there is not a black king on the board" do
      it "returns the board" do
        result = test_board.find_king_coordinates(test_board.board, "black")
        expect(result).to be_nil
      end
    end
  end

  describe "#update_previous_boards" do
    context "when adding the board to previous boards" do
      before do
        previous_boards = ["8/8/8/8/8/8/8/8 b - 4 9"]
        test_board.previous_boards = previous_boards
        test_board.update_previous_boards("white")
      end

      it "adds the current board in fen to previous_boards" do
        expect(test_board.previous_boards).to eq(["8/8/8/8/8/8/8/8 b - 4 9", "8/8/8/8/8/8/8/8 w - 5 10"])
      end
    end
  end
end
