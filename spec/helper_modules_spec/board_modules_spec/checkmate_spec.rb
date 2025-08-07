require_relative "../../../lib/helper_modules/board_modules/checkmate"
require_relative "../../../lib/helper_modules/board_modules/check"
require_relative "../../../lib/board"
require_relative "../../../lib/pieces/white_pawn"
require_relative "../../../lib/pieces/king"
require_relative "../../../lib/pieces/bishop"
require_relative "../../../lib/pieces/queen"

class TestBoard
  include Checkmate
  include Check
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def clone_and_update(piece_cords, move_cords)
    new_board = @board

    piece = new_board[piece_cords[0]][piece_cords[1]]

    new_board[piece_cords[0]][piece_cords[1]] = nil
    new_board[move_cords[0]][move_cords[1]] = piece

    new_board
  end

  def find_king_coordinates(board, color)
    board.each_with_index do |row, row_index|
      row.each_with_index do |piece, piece_index|
        return [row_index, piece_index] if piece&.name == "king" && piece&.color == color
      end
    end
  end
end

RSpec.describe Checkmate do
  subject(:test_board) { TestBoard.new }

  describe "#Checkmate" do
    context "when there are moves that can stop checkmate" do
      let(:dummy_king) { instance_double(King) }
      let(:dummy_queen) { instance_double(Queen) }
      let(:dummy_pawn) { instance_double(WhitePawn) }
      let(:dummy_bishop) { instance_double(Bishop) }

      before do
        test_board.board[7][7] = dummy_king
        test_board.board[7][5] = dummy_queen
        test_board.board[6][7] = dummy_pawn
        test_board.board[2][4] = dummy_bishop

        # allow(test_board).to receive(:find_king_coordinates).and_return([7, 7])
        allow(dummy_king).to receive_messages(name: "king", color: "white")
        allow(dummy_queen).to receive_messages(name: "queen", color: "black")
        allow(dummy_bishop).to receive_messages(name: "bishop", color: "white")
        allow(dummy_pawn).to receive_messages(name: "pawn", color: "white")
      end

      it "returns an array with those moves" do
        stop_check_positions = test_board.stop_check_positions("black")
        expect(stop_check_positions).to eq([[7, 6]])
      end
    end
  end
end
