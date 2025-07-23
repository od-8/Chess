require_relative "../../../lib/helper_modules/pieces_modules/inline_positions"
require_relative "../../../lib/pieces/rook"
require_relative "../../../lib/pieces/bishop"

RSpec.describe InlinePositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend InlinePositions } }

  context "when all move squares are available" do
    let(:random_cords) { [6, 6] }
    let(:random_color) { "black" }

    it "returns all legal moves" do
      legal_moves =
        [[7, 6], [5, 6], [4, 6], [3, 6], [2, 6], [1, 6], [0, 6], [6, 5], [6, 4], [6, 3], [6, 2], [6, 1], [6, 0], [6, 7]]
      moves = test_dummy.possible_inline_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when some move squares are occupied" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:black_rook) { instance_double(Rook) }
    let(:white_bishop) { instance_double(Bishop) }

    let(:random_cords) { [1, 1] }
    let(:random_color) { "black" }

    before do
      # Allows the pieces on the board to return their color
      allow(black_rook).to receive(:color).and_return("black")
      allow(white_bishop).to receive(:color).and_return("white")

      # Add pieces to the board
      board[5][1] = black_rook
      board[1][4] = white_bishop
    end

    it "returns all legal moves" do
      legal_moves =
        [[2, 1], [3, 1], [4, 1], [0, 1], [1, 0], [1, 2], [1, 3], [1, 4]]

      moves = test_dummy.possible_inline_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end
end
