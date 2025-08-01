require_relative "../../lib/pieces/king"
require_relative "../../lib/pieces/rook"

describe King do
  subject(:test_king) { described_class.new("king", "\u265a", "white") }

  let(:board) { Array.new(8) { Array.new(8) } }
  let(:piece_cords) { [7, 4] }
  let(:castling_rook) { instance_double(Rook) }

  describe "#legal_move?" do
    let(:piece_cords) { [6, 6] }

    context "when move is valid" do
      let(:move_cords) { [7, 7] }

      it "returns true" do
        legal_move = test_king.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(true)
      end
    end

    context "when move is invalid" do
      let(:move_cords) { [5, 4] }

      it "returns false" do
        legal_move = test_king.legal_move?(board, piece_cords, move_cords)
        expect(legal_move).to be(false)
      end
    end
  end

  describe "#castling" do
    let(:piece_cords) { [7, 4] }

    context "when queen side and king side castling are valid" do
      before do
        allow(test_king).to receive_messages(king_side_is_legal?: true, queen_side_is_legal?: true) # rubocop:disable RSpec/SubjectStub
      end

      it "returns all valid moves" do
        castling_moves = test_king.castling(board, piece_cords[0], piece_cords[1])
        expect(castling_moves).to eq([[7, 6], [7, 2]])
      end
    end

    context "when only king side castling is valid" do
      before do
        allow(test_king).to receive_messages(king_side_is_legal?: true, queen_side_is_legal?: false) # rubocop:disable RSpec/SubjectStub
      end

      it "returns all valid moves" do
        castling_moves = test_king.castling(board, piece_cords[0], piece_cords[1])
        expect(castling_moves).to eq([[7, 6]])
      end
    end
  end

  describe "#king_side_is_legal?" do
    context "when king side castling is valid" do
      before do
        board[7][7] = castling_rook
        allow(castling_rook).to receive_messages(name: "rook", color: "white", has_moved: false)
      end

      it "returns true" do
        legal_castling = test_king.king_side_is_legal?(board, piece_cords[0], piece_cords[1])
        expect(legal_castling).to be(true)
      end
    end

    context "when king side castling is invalid" do
      before do
        board[7][6] = castling_rook
        allow(castling_rook).to receive_messages(name: "rook", color: "white", has_moved: false)
      end

      it "returns true" do
        legal_castling = test_king.king_side_is_legal?(board, piece_cords[0], piece_cords[1])
        expect(legal_castling).to be(false)
      end
    end
  end

  describe "#queen side is legal" do
    context "when queen side castling is valid" do
      before do
        board[7][0] = castling_rook
        allow(castling_rook).to receive_messages(name: "rook", color: "white", has_moved: false)
      end

      it "returns true" do
        legal_castling = test_king.queen_side_is_legal?(board, piece_cords[0], piece_cords[1])
        expect(legal_castling).to be(true)
      end
    end

    context "when queen side castling is invalid" do
      before do
        board[7][1] = castling_rook
        allow(castling_rook).to receive_messages(name: "rook", color: "white", has_moved: false)
      end

      it "returns true" do
        legal_castling = test_king.queen_side_is_legal?(board, piece_cords[0], piece_cords[1])
        expect(legal_castling).to be(false)
      end
    end
  end
end
