require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"

# Contains methods for starting a new game or loading a previous game
class Chess # rubocop:disable Metrics/ClassLength
  attr_accessor :invalid_moves

  def initialize
    @invalid_moves = 3
  end

  def print_logo
    puts ""
    puts "   ______"
    puts "  / ___| |__   ___  ___ ___"
    puts ' | |   |  _ \ / _ \/ __/ __|'
    puts ' | |___| | | |  __/\__ \__ \ '
    puts '  \____|_| |_|\___||___/___/'
    puts ""
  end

  # Print the options of what to do
  def print_game_options
    puts "====================================="
    puts " Enter #{'1'.colorize(:green)} for a new game"
    puts "------------------------------------"
    puts " Enter #{'2'.colorize(:green)} to load a game"
    puts "====================================="
    puts ""
  end

  def print_game_info
    puts "================================================================"
    puts "  Enter any of these words to do their respective functions"
    puts '    "save" --> Save and quit the game'
    puts '    "quit" --> Quit the game without saving'
    puts '    "draw" --> Claim draw after the fify move rule is reached'
    puts "================================================================="
  end

  def start
    print_logo
    result = `ls lib/saved_games`
    result.empty? ? start_new_game : give_game_options
    print_end_message
  end

  def start_new_game
    puts " Welcome to chess, please enter the name of each of the players below:"
    player1, player2 = acquire_valid_names

    clear_screen

    print_game_info

    new_game = Game.new(player1, player2)
    new_game.play_game
  end

  def acquire_valid_names
    loop do
      print " Player 1 name: "
      player1 = gets.chomp.downcase.capitalize
      print " Player 2 name: "
      player2 = gets.chomp.downcase.capitalize

      @invalid_moves += 4

      return [player1, player2] unless player1 == player2

      puts " Your names cannot be the same".colorize(:red)
      puts ""
    end
  end

  def give_game_options
    print_game_options

    num = acquire_game_choice

    num == "1" ? start_new_game : load_prev_game
  end

  def load_prev_game
    print_previous_games

    file_name = acquire_prev_file_name

    new_game = Game.new

    clear_screen

    print_game_info

    new_game.load_prev_game(file_name)
    new_game.play_game
  end

  def print_previous_games
    prev_games = `ls lib/saved_games`

    puts "These are the games you can play"

    prev_games.split.each do |game|
      puts " - #{game}".colorize(:green)
      @invalid_moves += 1
    end

    puts ""

    @invalid_moves += 4
  end

  def acquire_prev_file_name
    games = `ls lib/saved_games`.split

    loop do
      print "Enter the name of the file you would like to load: "
      file_name = gets.chomp.downcase
      return file_name if games.include?("#{file_name}.yaml")

      @invalid_moves += 3

      puts "Enter a name of one of the files (without extension)".colorize(:red)
      puts ""
    end
  end

  # Gets the choice of what game they would like to play
  def acquire_game_choice
    loop do
      print "Enter the name of what you would like to do: "
      num = gets.chomp.downcase

      @invalid_moves += 3

      return num if %w[1 2].include?(num)

      puts "Enter either 1 or 2".colorize(:red)
      puts ""
    end
  end

  # Prints the thank you for playing message
  def print_end_message
    puts ""
    puts "Thank you for playing chess.".colorize(:green)
    puts ""
  end

  def clear_screen
    @invalid_moves.times do
      print "\e[1A\e[J"
      sleep 0.1
    end
  end
end

Chess.new.start
