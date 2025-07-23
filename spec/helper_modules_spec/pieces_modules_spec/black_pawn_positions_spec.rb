require_relative "../../../lib/helper_modules/pieces_modules/black_pawn_positions"
require_relative "../../../lib/pieces/white_pawn"

RSpec.describe BlackPawnPositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend BlackPawnPositions } }

  context "when all forward moves are available" do
    # These cords are used to show that pawn can move 1 forward and move 2 forward.
    # 2 move forward requires specific conditions to be a legal move.
    # That why I use these cords which are not random.
    let(:back_rank_cords) { [1, 5] }

    it "returns move 1 forward and move 2 forward" do
      legal_moves = [[2, 5], [3, 5]]

      moves = test_dummy.black_pawn_positions(board, back_rank_cords)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when taking is availabe" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:random_cords) { [5, 1] }

    # The first character(s) is for their direction nw = north west, n = north, ne = north east
    let(:nw_white_pawn) { instance_double(WhitePawn) }
    let(:n_white_pawn) { instance_double(WhitePawn) }
    let(:ne_white_pawn) { instance_double(WhitePawn) }

    before do
      allow(nw_white_pawn).to receive(:color).and_return("white")
      allow(n_white_pawn).to receive(:color).and_return("white")
      allow(ne_white_pawn).to receive(:color).and_return("white")

      board[6][0] = nw_white_pawn
      board[6][1] = n_white_pawn
      board[6][2] = ne_white_pawn
    end

    it "returns 2 taking options, one up and to the left, the other up and to the right" do
      legal_moves = [[6, 2], [6, 0]]

      moves = test_dummy.black_pawn_positions(board, random_cords)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when en passant is available" do
    let(:random_cords) { [4, 4] }

    let(:passantable_white_pawn) { instance_double(WhitePawn) }
    let(:random_white_pawn) { instance_double(WhitePawn) }

    before do
      allow(passantable_white_pawn).to receive_messages(name: "pawn", color: "white", can_be_passanted: true)

      board[5][4] = random_white_pawn
      board[4][5] = passantable_white_pawn
    end

    it "returns en passant to the right" do
      legal_moves = [[5, 5]]

      moves = test_dummy.black_pawn_positions(board, random_cords)
      expect(moves).to eq(legal_moves)
    end
  end
end
