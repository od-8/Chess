require_relative "../../../lib/helper_modules/pieces_modules/queen_positions"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/rook"

RSpec.describe QueenPositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend QueenPositions } }

  context "when all move squares are available" do
    let(:random_cords) { [1, 1] }
    let(:random_color) { "black" }

    it "returns all legal moves" do
      legal_moves = [[2, 0], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [0, 0], [0, 2], [2, 1], [3, 1], [4, 1],
                     [5, 1], [6, 1], [7, 1], [0, 1], [1, 0], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]

      moves = test_dummy.possible_queen_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when some move squares are occupied" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:random_cords) { [2, 2] }
    let(:random_color) { "white" }
    let(:black_queen) { instance_double(Queen) }
    let(:white_rook) { instance_double(Rook) }

    before do
      allow(black_queen).to receive(:color).and_return("black")
      allow(white_rook).to receive(:color).and_return("white")

      board[4][2] = black_queen
      board[2][4] = white_rook
    end

    it "returns all legal moves" do
      legal_moves = [[3, 1], [4, 0], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [1, 1], [0, 0], [1, 3], [0, 4], [3, 2],
                     [4, 2], [1, 2], [0, 2], [2, 1], [2, 0], [2, 3]]

      moves = test_dummy.possible_queen_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end
end
