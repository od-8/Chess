require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"
# Handles loading a previous game, starting new games
class Chess
  attr_accessor :player1, :player2, :invalid_moves

  def initialize
    @player1 = "Player1"
    @player2 = "Player2"
    # @invalid_moves = 15
    # its normally the number above however i skip the names intro part
    @invalid_moves = 11
    setup_game
  end

  def print_logo
    puts ""
    puts "              ______"
    puts "             / ___| |__   ___  ___ ___"
    puts '            | |   |  _ \ / _ \/ __/ __|'
    puts '            | |___| | | |  __/\__ \__ \ '
    puts '             \____|_| |_|\___||___/___/'
    puts ""
  end

  def print_options
    puts "+-----+-----+-----+-----+-----+".center(54)
    puts "| 1 - Play a new game         |".center(54)
    puts "+-----+-----+-----+-----+-----+".center(54)
    puts "| 2 - Load a saved game       |".center(54)
    puts "+-----+-----+-----+-----+-----+".center(54)
    puts "| 3 - Exit                    |".center(54)
    puts "+-----+-----+-----+-----+-----+".center(54)
  end

  def setup_names
    puts ""
    puts "    Who will be playing?"

    names = acquire_valid_names
    @player1 = names[0]
    @player2 = names[1]

    puts ""
    puts " #{player1} will have the #{'White'.colorize(:green)} peices."
    puts " #{player2} will have the #{'Black'.colorize(:green)} peices."
    sleep 2
    names
  end

  def acquire_player_names
    print "         Enter the first players name: "
    player1 = gets.chomp.capitalize
    print "         Enter the second players name: "
    player2 = gets.chomp.capitalize
    puts ""

    [player1, player2]
  end

  def acquire_valid_names
    loop do
      @invalid_moves += 3
      player1, player2 = acquire_player_names

      return [player1, player2] if player1 != player2 && player1 != "" && player2 != ""

      puts "Enter 2 different valid names".center(50).colorize(:red)
      puts ""
      @invalid_moves += 2
    end
  end

  def choose_game
    loop do
      puts ""
      print "         Enter the number for what you would like to do? "
      game = gets.chomp.downcase

      return game if %w[1 2 3].include?(game)
    end
  end

  def determine_game_choice
    num = choose_game

    case num.to_i
    when 1
      # New game
      # setup_names
      clear_screen
      new_game = Game.new(player1, player2)
      new_game.play_game
    when 2
      # Load previous game
    when 3
      # Quits
    end
  end

  def clear_screen
    puts "called"
    invalid_moves.times do
      print "\e[1A\e[J"
      sleep 0.1
    end
  end

  def setup_game
    print_logo
    print_options
    determine_game_choice
  end
end

Chess.new
