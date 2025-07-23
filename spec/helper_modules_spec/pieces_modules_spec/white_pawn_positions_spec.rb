require_relative "../../../lib/helper_modules/pieces_modules/white_pawn_positions"
require_relative "../../../lib/pieces/black_pawn"

RSpec.describe WhitePawnPositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend WhitePawnPositions } }

  context "when all forward moves are available" do
    # ]These cords are used to show that pawn can move 1 forward and move 2 forward.
    # 2 move forward requires specific conditions to be a legal move.
    # That why I use these cords which are not random.
    let(:back_rank_cords) { [6, 2] }

    it "returns move 1 forward and move 2 forward" do
      legal_moves = [[5, 2], [4, 2]]

      moves = test_dummy.white_pawn_positions(board, back_rank_cords)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when taking is availabe" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:random_cords) { [4, 3] }

    # The first character(s) is for their direction nw = north west, n = north, ne = north east
    let(:nw_black_pawn) { instance_double(BlackPawn) }
    let(:n_black_pawn) { instance_double(BlackPawn) }
    let(:ne_black_pawn) { instance_double(BlackPawn) }

    before do
      allow(nw_black_pawn).to receive(:color).and_return("black")
      allow(n_black_pawn).to receive(:color).and_return("black")
      allow(ne_black_pawn).to receive(:color).and_return("black")

      board[3][2] = nw_black_pawn
      board[3][3] = n_black_pawn
      board[3][4] = ne_black_pawn
    end

    it "returns 2 taking options, one up and to the left, the other up and to the right" do
      legal_moves = [[3, 4], [3, 2]]

      moves = test_dummy.white_pawn_positions(board, random_cords)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when en passant is available" do
    let(:random_cords) { [3, 1] }

    let(:passantable_black_pawn) { instance_double(BlackPawn) }
    let(:random_black_pawn) { instance_double(BlackPawn) }

    before do
      allow(passantable_black_pawn).to receive_messages(name: "pawn", color: "black", can_be_passanted: true)

      board[2][1] = random_black_pawn
      board[3][0] = passantable_black_pawn
    end

    it "returns en passant to the left" do
      legal_moves = [[2, 0]]

      moves = test_dummy.white_pawn_positions(board, random_cords)
      expect(moves).to eq(legal_moves)
    end
  end
end
