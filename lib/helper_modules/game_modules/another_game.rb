# Methods for asking and starting a new game
module AnotherGame
  # Based on player inputs it either starts a new game or says thank you message
  def another_game
    return unless another_game?

    @invalid_moves = 26
    clear_screen
    new_game = Game.new(@player1.name, @player2.name)
    new_game.play_game
  end

  # Asks if players would like to play another game
  def another_game?
    loop do
      puts " Enter yes if you would like to play another game or no if you want to quit"
      puts ""
      print " Your descision: "
      answer = gets.chomp.downcase
      puts ""

      return true if answer == "yes"
      return false if answer == "no"
    end
  end
end
