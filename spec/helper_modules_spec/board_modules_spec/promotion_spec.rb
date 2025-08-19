require_relative "../../../lib/helper_modules/board_modules/promotion"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/queen"
require_relative "../../../lib/pieces/knight"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/black_pawn"

RSpec.describe Promotion do
  subject(:dummy_class) { Class.new { extend Promotion } }

  let(:test_white_pawn) { instance_double(WhitePawn) }
  let(:test_black_pawn) { instance_double(BlackPawn) }

  describe "#promotion" do
    context "when the piece is a white pawn and its promoting to a bishop" do
      before do
        allow(test_white_pawn).to receive(:color).and_return("white")
        allow(dummy_class).to receive(:ask_for_piece).and_return("bishop") # rubocop:disable RSpec/SubjectStub
      end

      it "returns a new bishop" do
        piece = dummy_class.promotion(test_white_pawn, [0, 7])
        expect(piece).to be_an_instance_of(Bishop)
      end
    end

    context "when the piece is a black pawn and its promoting to a rook" do
      before do
        allow(test_black_pawn).to receive(:color).and_return("black")
        allow(dummy_class).to receive(:ask_for_piece).and_return("rook") # rubocop:disable RSpec/SubjectStub
      end

      it "returns a new rook" do
        piece = dummy_class.promotion(test_black_pawn, [7, 0])
        expect(piece).to be_an_instance_of(Rook)
      end
    end

    context "when a white pawn isnt promoting" do
      before do
        allow(test_white_pawn).to receive(:color).and_return("white")
      end

      it "returns the passed white pawn" do
        piece = dummy_class.promotion(test_white_pawn, [1, 6])
        expect(piece).to eq(test_white_pawn)
      end
    end

    context "when a black pawn isnt promoting" do
      before do
        allow(test_black_pawn).to receive(:color).and_return("black")
      end

      it "returns the passed black pawn" do
        piece = dummy_class.promotion(test_black_pawn, [6, 1])
        expect(piece).to eq(test_black_pawn)
      end
    end
  end

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
      it "returns a new instance of Knight" do
        piece = dummy_class.new_black_piece("knight")
        expect(piece).to be_an_instance_of(Knight)
      end
    end
  end
end
