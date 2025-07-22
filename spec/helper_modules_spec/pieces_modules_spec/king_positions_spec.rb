require_relative "../../../lib/helper_modules/pieces_modules/king_positions"

RSpec.describe KingPositions do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend KingPositions } }

  context "when all move squares are availabe" do
    let(:random_cords) { [1, 1] }
    let(:random_color) { "black" }

    it "returns all legal moves" do
      legal_move = [[2, 1], [2, 0], [2, 2], [1, 0], [1, 2], [0, 1], [0, 0], [0, 2]]
      moves = test_dummy.possible_king_moves(random_cords[0], random_cords[1])
      expect(moves).to eq(legal_move)
    end
  end
end
