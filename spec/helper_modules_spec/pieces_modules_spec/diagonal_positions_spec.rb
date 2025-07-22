require_relative "../../../lib/helper_modules/pieces_modules/diagonal_positions"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/knight"

RSpec.describe DiagonalPositions do # rubocop:disable Metrics/BlockLength
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend DiagonalPositions } }

  context "when all move squares are available" do
    let(:random_cords) { [1, 1] }
    let(:random_color) { "white" }

    let(:legal_moves) { [[2, 0], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [0, 0], [0, 2]] }

    it "returns all legal moves" do
      moves = test_dummy.possible_bishop_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end

  context "when some move squares are occupied" do
    let(:white_pawn) { double(WhitePawn) }
    let(:black_knight) { double(Knight) }

    let(:random_cords) { [3, 3] }
    let(:random_color) { "black" }

    let(:legal_moves) { [[4, 2], [5, 1], [6, 0], [4, 4], [5, 5], [2, 2], [1, 1], [0, 0], [2, 4]] }

    before do
      # Allows the pieces on the board to return their color
      allow(white_pawn).to receive(:color).and_return("white")
      allow(black_knight).to receive(:color).and_return("black")

      # Add pieces to the boardz
      board[6][6] = black_knight
      board[2][4] = white_pawn
    end

    it "returns all legal moves" do
      moves = test_dummy.possible_bishop_moves(board, random_cords, random_color)
      expect(moves).to eq(legal_moves)
    end
  end
end
