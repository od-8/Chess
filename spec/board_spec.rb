# This file contains all the methods for testing the board methods
require_relative "../lib/board"

describe Board do
  subject(:test_board) { described_class.new }

  describe "#move" do
    context "when d2 pawn is moved to d4 is updates the board" do
      before do
        test_board.move([1, 3], [3, 3])
      end
    end

    it "board now has pawn at d4 and no pawn at d2" do
      board = test_board.instance_variable_get(:@board)
      piece_postion = board[1][3]
      move_position = board[3][3]
      expect(piece_postion).to be_nil?
      expect(move_position).not_to be_nil?
    end
  end
end
