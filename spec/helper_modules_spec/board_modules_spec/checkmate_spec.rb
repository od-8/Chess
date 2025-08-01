require_relative "../../../lib/helper_modules/board_modules/checkmate"
# require_relative "../../../lib/helper_modules/pieces_modules/black_pawn_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/diagonal_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/inline_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/king_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/knight_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/queen_positions"
# require_relative "../../../lib/helper_modules/pieces_modules/white_pawn_positions"

require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/king"
require_relative "../../../lib/pieces/queen"

RSpec.describe Checkmate do
  let(:board) { Array.new(8) { Array.new(8) } }
  let(:test_dummy) { Class.new { extend Checkmate } }

  describe "#stop_check_postions" do
    context "when there are moves that can stop checkmate for white" do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:dummy_king) { instance_double(King) }
      let(:dummy_queen) { instance_double(Queen) }
      let(:dummy_pawn_one) { instance_double(WhitePawn) }
      let(:dummy_pawn_two) { instance_double(WhitePawn) }

      before do
        board[7][7] = dummy_king
        board[7][4] = dummy_queen
        board[5][7] = dummy_pawn_one
        board[6][6] = dummy_pawn_two

        allow(dummy_king).to receive_messages(name: "king", color: "white")
        allow(dummy_queen).to receive_messages(name: "queen", color: "black")
        allow(dummy_pawn_one).to receive_messages(name: "pawn", color: "white")
        allow(dummy_pawn_two).to receive_messages(name: "pawn", color: "white")
      end

      it "returns an array with those moves" do
        positions_to_stop_check = test_dummy.stop_check_positions("white")
        expect(positions_to_stop_check).to eq([[6, 7]])
      end
    end

    context "when there are no moves that can stop checkmate for black" do
      xit "returns an empty array" do
        
      end
    end
  end
end
