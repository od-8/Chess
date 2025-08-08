require_relative "../../../lib/helper_modules/board_modules/promotion"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/knight"

RSpec.describe Promotion do
  subject(:dummy_class) { Class.new { extend Promotion } }

  describe "#legal_piece?" do
    context "when piece is legal" do
      it "returns true" do
        legal_piece = dummy_class.legal_piece?("queen")
        expect(legal_piece).to be(true)
      end
    end

    context "when piece isnt legal" do
      it "returns fale" do
        legal_piece = dummy_class.legal_piece?("pawn")
        expect(legal_piece).to be(false)
      end
    end
  end

  describe "#new_white_piece" do
    context "when player chooses queen" do
      it "returns a new instance of Queen" do
        piece = dummy_class.new_white_piece("queen")
        expect(piece).to be_an_instance_of(Queen)
      end
    end
  end

  describe "#new_black_piece" do
    context "when player chooses a knight" do
      it "returns a new instance of Queen" do
        piece = dummy_class.new_black_piece("knight")
        expect(piece).to be_an_instance_of(Knight)
      end
    end
  end
end
