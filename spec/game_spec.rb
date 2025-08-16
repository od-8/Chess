require_relative "../lib/game"
require_relative "../lib/board"
require_relative "../lib/player"
require_relative "../lib/pieces/knight"
require_relative "../lib/pieces/bishop"
require_relative "../lib/pieces/black_pawn"

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

  describe "#play_game" do
    context "when the user inputs quit" do
      before do
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_loop).and_return("quit") # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:another_game) # rubocop:disable RSpec/SubjectStub
      end

      it "doesnt call another game" do
        test_game.play_game
        expect(test_game).not_to have_received(:another_game) # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when the user inputs save" do
      before do
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_loop).and_return("save") # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:another_game) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:save_game) # rubocop:disable RSpec/SubjectStub
      end

      it "doesnt call another game" do
        test_game.play_game
        expect(test_game).not_to have_received(:another_game) # rubocop:disable RSpec/SubjectStub
      end
    end

    context "when the user inputs draw" do
      before do
        allow(test_game).to receive(:print_board) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:game_loop).and_return("draw") # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:another_game) # rubocop:disable RSpec/SubjectStub
        allow(test_game).to receive(:draw_game) # rubocop:disable RSpec/SubjectStub
      end

      it "doesnt call another game" do
        test_game.play_game
        expect(test_game).not_to have_received(:another_game) # rubocop:disable RSpec/SubjectStub
      end
    end
  end

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
        expect(test_board).to have_received(:update_previous_boards).once
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

      it "calls Board#update_previous_boards three times" do
        test_game.game_loop
        expect(test_board).to have_received(:update_previous_boards).exactly(3).times
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

    context "when the user has inputed save" do
      before do
        allow(test_game).to receive(:move_loop).and_return("save") # rubocop:disable RSpec/SubjectStub
      end

      it "returns save" do
        result = test_game.game_loop
        expect(result).to eq("save")
      end
    end
  end

  describe "#move_loop" do
    let(:random_cords) { [[[0, 0], [1, 1]], [[1, 1], [2, 2]], [[2, 2], [3, 3]]] }

    context "when valid_move? is false once" do
      before do
        allow(test_game).to receive(:legal_input).and_return(random_cords[0], random_cords[1]) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive_message_chain(:board, :[], :[]).and_return(nil) # rubocop:disable RSpec/MessageChain
        allow(test_game).to receive(:allowed_move?).and_return(false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:move)
      end

      it "calls Board#move once" do
        test_game.move_loop
        expect(test_board).to have_received(:move).once
      end
    end

    context "when valid_move? is false two times" do
      before do
        allow(test_game).to receive(:legal_input).and_return(random_cords[0], random_cords[1], random_cords[2]) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive_message_chain(:board, :[], :[]).and_return(nil) # rubocop:disable RSpec/MessageChain
        allow(test_game).to receive(:allowed_move?).and_return(false, false, true) # rubocop:disable RSpec/SubjectStub
        allow(test_board).to receive(:move)
      end

      it "calls Board#move two times" do
        test_game.move_loop
        expect(test_board).to have_received(:move).once
      end
    end

    context "when the user has inputed quit" do
      before do
        allow(test_game).to receive(:legal_input).and_return("quit") # rubocop:disable RSpec/SubjectStub
      end

      it "returns quit" do
        result = test_game.move_loop
        expect(result).to eq("quit")
      end
    end

    context "when the user has inputed draw" do
      before do
        allow(test_game).to receive(:legal_input).and_return("draw") # rubocop:disable RSpec/SubjectStub
      end

      it "returns draw" do
        result = test_game.move_loop
        expect(result).to eq("draw")
      end
    end

    context "when the user has inputed save" do
      before do
        allow(test_game).to receive(:legal_input).and_return("save") # rubocop:disable RSpec/SubjectStub
      end

      it "returns save" do
        result = test_game.move_loop
        expect(result).to eq("save")
      end
    end
  end

  describe "#allowed_move?" do
    let(:test_knight) { instance_double(Knight) }

    context "when the move is allowed" do
      before do
        allow(test_board).to receive(:board)
        allow(test_knight).to receive(:legal_move?).and_return(true)
        allow(test_knight).to receive(:color)
        allow(test_board).to receive(:clone_and_update)
        allow(test_board).to receive_messages(unnocupied_square?: true, in_check?: false)
      end

      it "returns true" do
        result = test_game.allowed_move?(test_knight, [3, 3], [5, 2])
        expect(result).to be(true)
      end
    end

    context "when the piece cant make that move" do
      before do
        allow(test_board).to receive(:board)
        allow(test_knight).to receive(:legal_move?).and_return(false)
        allow(test_knight).to receive(:color)
        allow(test_board).to receive(:clone_and_update)
        allow(test_board).to receive_messages(unnocupied_square?: true, in_check?: false)
      end

      it "returns false" do
        result = test_game.allowed_move?(test_knight, [3, 3], [5, 2])
        expect(result).to be(false)
      end
    end

    context "when the move puts them in check" do
      before do
        allow(test_board).to receive(:board)
        allow(test_knight).to receive(:legal_move?).and_return(true)
        allow(test_knight).to receive(:color)
        allow(test_board).to receive(:clone_and_update)
        allow(test_board).to receive_messages(unnocupied_square?: true, in_check?: true)
      end

      it "returns false" do
        result = test_game.allowed_move?(test_knight, [3, 3], [5, 2])
        expect(result).to be(false)
      end
    end
  end

  describe "#legal_piece_move?" do
    let(:test_bihsop) { instance_double(Bishop) }

    context "when the piece can make that move and the square is free" do
      before do
        allow(test_board).to receive(:board)
        allow(test_bihsop).to receive(:legal_move?).and_return(true)
        allow(test_board).to receive(:unnocupied_square?).and_return(true)
      end

      it "returns true" do
        result = test_game.legal_piece_move?(test_bihsop, [2, 3], [5, 6])
        expect(result).to be(true)
      end
    end

    context "when the piece cant make that move" do
      before do
        allow(test_board).to receive(:board)
        allow(test_bihsop).to receive(:legal_move?).and_return(false)
        allow(test_board).to receive(:unnocupied_square?).and_return(true)
      end

      it "returns false" do
        result = test_game.legal_piece_move?(test_bihsop, [2, 3], [5, 6])
        expect(result).to be(false)
      end
    end

    context "when the square isnt free" do
      before do
        allow(test_board).to receive(:board)
        allow(test_bihsop).to receive(:legal_move?).and_return(true)
        allow(test_board).to receive(:unnocupied_square?).and_return(false)
      end

      it "returns false" do
        result = test_game.legal_piece_move?(test_bihsop, [2, 3], [5, 6])
        expect(result).to be(false)
      end
    end
  end

  describe "#valid_move?" do
    let(:test_black_pawn) { instance_double(BlackPawn) }

    context "when not in check" do
      before do
        allow(test_black_pawn).to receive(:color)
        allow(test_board).to receive(:clone_and_update)
        allow(test_board).to receive(:in_check?).and_return(false)
      end

      it "returns true" do
        result = test_game.valid_move?(test_black_pawn, [1, 0], [3, 0])
        expect(result).to be(true)
      end
    end

    context "when in check" do
      before do
        allow(test_black_pawn).to receive(:color)
        allow(test_board).to receive(:clone_and_update)
        allow(test_board).to receive(:in_check?).and_return(true)
      end

      it "returns false" do
        result = test_game.valid_move?(test_black_pawn, [1, 0], [3, 0])
        expect(result).to be(false)
      end
    end
  end

  describe "#game_over?" do
    context "when checkmate is true" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_checkmate?: true, in_check?: true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.game_over?
        expect(result).to be(true)
      end
    end

    context "when insufficient material is true" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_check?: false, in_checkmate?: false, threefold_repetition?: false,
                                              insufficient_material?: true)
        allow(test_game).to receive(:puts) # rubocop:disable RSpec/SubjectStub
      end

      it "returns true" do
        result = test_game.game_over?
        expect(result).to be(true)
      end
    end

    context "when there is no reason to end the game" do
      before do
        allow(test_board).to receive(:board)
        allow(test_board).to receive_messages(in_check?: false, in_checkmate?: false, threefold_repetition?: false,
                                              insufficient_material?: false)
      end

      it "returns false" do
        result = test_game.game_over?
        expect(result).to be(false)
      end
    end
  end

  describe "#update_currnet_player" do
    context "when current player is player1" do
      it "updates current player to player2" do
        test_game.update_current_player
        expect(test_game.current_player).to be(test_player_two)
      end
    end

    context "when current player is player2" do
      before do
        test_game.current_player = test_player_two
      end

      it "updates current player to player 1" do
        test_game.update_current_player
        expect(test_game.current_player).to be(test_player_one)
      end
    end
  end
end
