require_relative "../lib/board"
require_relative "../lib/pieces/white_pawn"
require_relative "../lib/pieces/black_pawn"
require_relative "../lib/pieces/knight"
require_relative "../lib/pieces/bishop"
require_relative "../lib/pieces/rook"
require_relative "../lib/pieces/queen"
require_relative "../lib/pieces/king"

describe Board do
  subject(:test_board) { described_class.new("8/8/8/8/8/8/8/8") }

  describe "#move" do
    context "when a white pawn is moving 1 forward" do
      let(:white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }

      before do
        test_board.half_moves = 20
        test_board.board[4][5] = white_pawn
        test_board.move(white_pawn, [4, 5], [3, 5])
      end

      it "changes the board so the pawn is at the move positon" do
        expect(test_board.board[3][5]).to eq(white_pawn)
      end

      it "adds 1 to full moves" do
        expect(test_board.full_moves).to eq(1)
      end

      it "resets half moves to 0" do
        expect(test_board.half_moves).to eq(0)
      end
    end
  end

  describe "#move_piece" do
    context "when a knight moves 2 up and 1 to the right" do
      let(:knight) { Knight.new("knight", "\u265e", "black") }

      it "changes the board so the knight is at the move position" do
        test_board.move(knight, [0, 0], [2, 1])
        expect(test_board.board[2][1]).to eq(knight)
      end
    end
  end

  describe "#handle_piece" do
    context "when the piece is a bishop" do
      let(:bishop) { Bishop.new("bishop", "\u2657", "white") }

      it "returns piece" do
        piece = test_board.handle_piece(bishop, [7, 0], [4, 4])
        expect(piece).to eq(bishop)
      end
    end

    context "when the piece is a rook" do
      let(:rook) { Rook.new("rook", "\u265c", "black") }

      before do
        test_board.handle_piece(rook, [7, 7], [7, 5])
      end

      it "updates Rooks has_moved status" do
        expect(rook.has_moved).to be(true)
      end

      it "returns the rook" do
        piece = test_board.handle_piece(rook, [7, 7], [7, 5])
        expect(piece).to eq(rook)
      end
    end

    context "when the piece is a white pawn that is moving 2 forward" do
      let(:black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

      it "updates Pawn can_be_passanted status" do
        test_board.handle_piece(black_pawn, [1, 2], [3, 2])
        expect(black_pawn.can_be_passanted).to be(true)
      end

      it "updates passantable_pawn_cords" do
        test_board.handle_piece(black_pawn, [1, 2], [3, 2])
        expect(test_board.passantable_pawn_cords).to eq([3, 2])
      end

      it "returns the pawn" do
        piece = test_board.handle_piece(black_pawn, [1, 2], [3, 2])
        expect(piece).to eq(black_pawn)
      end
    end
  end

  describe "#handle_pawn" do
    context "when the piece isnt a pawn" do
      let(:queen) { Queen.new("queen", "\u2655", "white") }

      it "returns the piece" do
        piece = test_board.handle_pawn(queen, [1, 7], [3, 5])
        expect(piece).to eq(queen)
      end
    end

    context "when the pawn is en passanting" do
      let(:white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }
      let(:black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

      before do
        test_board.board[3][3] = black_pawn
        test_board.passantable_pawn_cords = [3, 3]
        black_pawn.can_be_passanted = true
        test_board.handle_pawn(white_pawn, [3, 2], [2, 3])
      end

      it "sets the passantable pawns can_be_passanted status to false" do
        expect(black_pawn.can_be_passanted).to be(false)
      end

      it "sets the passantable_pawn_cords to nil" do
        expect(test_board.passantable_pawn_cords).to be_nil
      end

      it "removes the passantable pawns from the board" do
        expect(test_board.board[3][3]).to be_nil
      end
    end
  end

  describe "#handle_rook" do
    context "when the piece isnt a rook" do
      let(:knight) { Knight.new("knight", "\u2658", "white") }

      it "returns the piece" do
        piece = test_board.handle_rook(knight)
        expect(piece).to be_nil
      end
    end

    context "when the piece is a rook" do
      let(:rook) { Rook.new("rook", "\u265c", "black") }

      it "updates rooks move status" do
        test_board.handle_rook(rook)
        expect(rook.has_moved).to be(true)
      end
    end
  end

  describe "#handle_king" do
    let(:king) { King.new("king", "\u2654", "white") }

    context "when the piece isnt a king" do
      let(:knight) { Knight.new("knight", "\u2658", "white") }

      it "returns nil" do
        piece = test_board.handle_king(knight, [6, 7], [4, 6])
        expect(piece).to be_nil
      end
    end

    context "when the piece is a king and the king is castling king side" do
      let(:rook) { Rook.new("rook", "\u2656", "white") }

      before do
        test_board.board[7][0] = rook
        test_board.handle_king(king, [7, 4], [7, 2])
      end

      it "moves the rook to [7, 3]" do
        expect(test_board.board[7][3]).to eq(rook)
      end

      it "sets the previous position of the rook to nil" do
        expect(test_board.board[7][7]).to be_nil
      end

      it "updates the kings moved status to true" do
        expect(king.has_moved).to be(true)
      end
    end
  end

  describe "#unnocupied_square?" do
    let(:white_pawn) { WhitePawn.new("pawn", "\u2659", "white") }
    let(:knight) { Knight.new("knight", "\u2658", "white") }

    context "when the square isnt occupied" do
      it "returns true" do
        unnocupied_square = test_board.unnocupied_square?(knight, [3, 3])
        expect(unnocupied_square).to be(true)
      end
    end

    context "when the square is occupied" do
      before do
        test_board.board[3][3] = white_pawn
      end

      it "returns false" do
        unnocupied_square = test_board.unnocupied_square?(knight, [3, 3])
        expect(unnocupied_square).to be(false)
      end
    end
  end

  describe "#clone_and_update" do
    let(:black_pawn) { BlackPawn.new("pawn", "\u265f", "black") }

    context "when deep copying the board and making a move" do
      before do
        test_board.board[4][4] = black_pawn
      end

      it "returns the board with the piece in the new position" do
        cloned_board = test_board.clone_and_update([4, 4], [5, 4])
        expect(cloned_board[5][4]).to be_an_instance_of(BlackPawn)
      end
    end
  end

  describe "#find_king_coordiantes" do
    let(:king) { King.new("king", "\u2654", "white") }

    context "when there is a king on the board" do
      before do
        test_board.board[3][3] = king
      end

      it "returns the coordiantes of that king" do
        king_cords = test_board.find_king_coordinates(test_board.board, king.color)
        expect(king_cords).to eq([3, 3])
      end
    end

    context "when there are no kings on the board" do
      it "returns the board" do
        king_cords = test_board.find_king_coordinates(test_board.board, king.color)
        expect(king_cords).to be_nil
      end
    end
  end

  describe "#update_previous_boards" do
    context "when updating previous boards" do
      let(:queen) { Queen.new("queen", "\u2655", "white") }

      before do
        test_board.previous_boards = ["3Q4/8/8/8/8/8/8/8 w - 0 0"]

        test_board.board[4][4] = queen

        random_color = "black"
        test_board.update_previous_boards(random_color)
      end

      it "add the current board to @previous_boards" do
        previous_boards = ["3Q4/8/8/8/8/8/8/8 w - 0 0", "8/8/8/8/4Q3/8/8/8 b - 0 0"]

        expect(test_board.previous_boards).to eq(previous_boards)
      end
    end
  end
end

# handle_king
# - return if piece name isnt king
# - calls castling
# - calls King#update_move_status
