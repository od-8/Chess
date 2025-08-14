require_relative "../lib/game"
require_relative "../lib/board"
require_relative "../lib/player"

describe Game do
  subject(:test_game) do
    game = described_class.new
    game.instance_variable_set(:@board, test_board)
    game.instance_variable_set(:@player1, test_player_one)
    game.instance_variable_set(:@player2, test_player_two)
    game.instance_variable_set(:@current_player, test_player_one)
    game
  end

  let(:test_board) { instance_double(Board) }
  let(:test_player_one) { Player.new("player1", "white") }
  let(:test_player_two) { Player.new("player2", "black") }

  describe "#game_loop" do
    context "when game_over is false once" do
      before do
        allow(test_game).to receive(:move_loop) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:clear_screen) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_over?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:check?).and_return(false) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:update_current_player) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:update_previous_boards)
      end

      it "calls Board#update_previous_boards once" do
        test_game.game_loop
        expect(test_game).to have_received(:update_current_player).once # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when game_over is false three times" do
      before do
        allow(test_game).to receive(:move_loop) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:clear_screen) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_over?).and_return(false, false, false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:check?).and_return(false) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:update_current_player) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:update_previous_boards)
      end

      it "calls Board#update_previous_boards once" do
        test_game.game_loop
        expect(test_game).to have_received(:update_current_player).exactly(3).times # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when white king is in check" do
      before do
        allow(test_board).to receive(:board)
        allow(test_game).to receive(:move_loop) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:clear_screen) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_over?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:in_check?).with(test_board.board, "white").and_return(true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:in_check?).with(test_board.board, "black").and_return(false) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:puts).with("") # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:in_check?).and_return(true)
        allow(test_board).to receive(:update_previous_boards)
      end

      it "prints line saying king is in check" do
        test_game.game_loop

        check_line = "\e[0;32;49m White king is in check\e[0m"
        expect(test_game).to have_received(:puts).with(check_line) # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when updating the current player" do
      before do
        allow(test_game).to receive(:move_loop) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:clear_screen) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_over?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:check?) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:update_previous_boards)
      end

      it "updates current player" do
        test_game.game_loop

        expect(test_game.current_player).to eq(test_player_two)
      end
    end

    context "when updating previous boards" do
      before do
        allow(test_game).to receive(:move_loop) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:clear_screen) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_over?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:check?) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:update_current_player) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:update_previous_boards)
      end

      it "updates previous boards" do
        test_game.game_loop

        expect(test_board).to have_received(:update_previous_boards).once
      end
    end

    context "when the user has inputed quit" do
      before do
        allow(test_game).to receive(:move_loop).and_return("quit") # rubocop:disable RSpec/SubjectStub
      end

      it "returns quit" do
        result = test_game.game_loop
        expect(result).to eq("quit")
      end
    end

    context "when the user has inputed draw" do
      before do
        allow(test_game).to receive(:move_loop).and_return("draw") # rubocop:disable RSpec/SubjectStub
      end

      it "returns draw" do
        result = test_game.game_loop
        expect(result).to eq("draw")
      end
    end
  end

  describe "#move_loop" do
    context "when valid_move? is false once" do
      before do
        fake_piece = instance_double("piece", color: :white) # rubocop:disable RSpec/VerifiedDoubleReference
        allow(test_game).to receive(:legal_move).and_return([fake_piece, nil, nil]) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:move) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:valid_move?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
      end

      it "calls #move once" do
        test_game.move_loop
        expect(test_game).to have_received(:move).once # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when valid_move? is false 4 times" do
      before do
        fake_piece = instance_double("piece", color: :white) # rubocop:disable RSpec/VerifiedDoubleReference
        allow(test_game).to receive(:legal_move).and_return([fake_piece, nil, nil]) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:move) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:valid_move?).and_return(false, false, false, false, true) # rubocop:disable RSpec/SubjectStub
      end

      it "calls #move once" do
        test_game.move_loop
        expect(test_game).to have_received(:move).once # rubocop:disable RSpec/SubjectStub
      end
    end
  end
end

# Tests
# move_loop
# - when the valid_move? is true if calls board_move then breaks
# - returns "quit" or "draw" if thats what is receives

# legal_move
# - returns "quit" or "draw" if thats what is receives
# - when_legal_piece_move? returns true it then returns the piece, piece_cords, move_cords tehn breaks the loop

# legal_piece_move?
# - returns true if the square is unnocupied and the piece can make that move
# - returns false

# valid_move?
# - returns false if the piece color is the same as the current player color and that players move has put them in check
# - returns true

# game_over?
# - returns true if something causes the game to end, checkmate, stalemate, threefold, insufficient
# - returns false

# update_current_player
# - updates the current player to the other player
