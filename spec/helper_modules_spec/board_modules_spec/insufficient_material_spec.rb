require_relative "../../../lib/helper_modules/board_modules/insufficient_material"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/knight"

RSpec.describe InsufficientMaterial do
  subject(:board) { Board.new("8/8/8/8/8/8/8/8/") }

  let(:king_arr) { [instance_double(King)] }

  describe "#not_enough_material" do
    context "when there is 1 white king and 1 white bishop" do
      let(:dummy_bishop) { instance_double(Bishop) }

      it "returns true" do
        bishops = [dummy_bishop]
        insufficient_material = board.not_enough_material?(bishops, [], king_arr)
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 black kings and 2 black knights" do
      let(:dummy_knight_one) { instance_double(Knight) }
      let(:dummy_knight_two) { instance_double(Knight) }

      it "returns true" do
        knights = [dummy_knight_one, dummy_knight_two]
        insufficient_material = board.not_enough_material?([], knights, king_arr)
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 white king" do
      it "retunrs true" do
        insufficient_material = board.not_enough_material?([], [], king_arr)
        expect(insufficient_material).to be(true)
      end
    end

    context "when there is 1 black king and 2 black bishop" do
      let(:dummy_bishop_one) { instance_double(Bishop) }
      let(:dummy_bishop_two) { instance_double(Bishop) }

      it "returns false" do
        bishops = [dummy_bishop_one, dummy_bishop_two]
        insufficient_material = board.not_enough_material?(bishops, [], king_arr)
        expect(insufficient_material).to be(false)
      end
    end
  end
end
