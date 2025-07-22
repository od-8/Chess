require_relative "../../../lib/helper_modules/pieces_modules/knight_positions"

RSpec.describe KnightPositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend KnightPositions } }

  context "when all move squares available" do
    let(:random_cords) { [3, 3] }
    let(:random_color) { "white" }

    it "returns all legal moves" do
      legal_moves = [[4, 5], [2, 5], [4, 1], [2, 1], [1, 2], [1, 4], [5, 2], [5, 4]]
      moves = test_dummy.possible_knight_moves(random_cords[0], random_cords[1])
      expect(moves).to eq(legal_moves)
    end
  end
end
