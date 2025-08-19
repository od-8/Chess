require_relative "../../../lib/helper_modules/board_modules/threefold_repetition"
require_relative "../../../lib/board"

RSpec.describe ThreefoldRepetition do
  subject(:board) { Board.new("8/8/8/8/8/8/8/8/") }

  describe "#threefold_repition?" do
    context "when there is threefold repition" do
      before do
        board.previous_boards = [
          "4K3/8/8/8/8/8/8/4K3",
          "3K4/8/8/8/8/8/8/3K4",
          "4K3/8/8/8/8/8/8/4K3",
          "3K4/8/8/8/8/8/8/3K4",
          "4K3/8/8/8/8/8/8/4K3"
        ]
      end

      it "returns true" do
        expect(board.threefold_repetition?).to be(true)
      end
    end

    context "when there isnt threefold repition" do
      before do
        board.previous_boards = [
          "4K3/8/8/8/8/8/8/4K3",
          "3K4/8/8/8/8/8/8/3K4",
          "4K3/8/8/8/8/8/8/4K3",
          "3K4/8/8/8/8/8/8/3K4"
        ]
      end

      it "returns false" do
        expect(board.threefold_repetition?).to be(false)
      end
    end
  end
end
