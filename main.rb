require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"

def print_logo
  puts ""
  puts "               ______"
  puts "              / ___| |__   ___  ___ ___"
  puts '             | |   |  _ \ / _ \/ __/ __|'
  puts '             | |___| | | |  __/\__ \__ \ '
  puts '              \____|_| |_|\___||___/___/'
  puts ""
end

def setup_players # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  puts " Who will be playing?"
  puts ""
  player1 = nil
  player2 = nil

  loop do
    print " Enter the first players name: "
    player1 = gets.chomp.capitalize
    print " Enter the second players name: "
    player2 = gets.chomp.capitalize

    break if player1 != player2

    puts " Your names cant be the same".colorize(:red)
    puts ""
  end

  puts ""
  puts " #{player1} will have the #{'White'.colorize(:green)} peices."
  puts " #{player2} will have the #{'Black'.colorize(:green)} peices."

  [player1, player2]
end

# print "\e[#{1}A\e[J"

def play_chess # rubocop:disable Metrics/MethodLength
  game = front_page

  case game
  when "1"
    # names = setup_players
    # new_game = Game.new(names[0], names[1])
    clear
    new_game = Game.new
    new_game.play_game
  when "2"
    clear
    # load game
  when "3"
    clear
    # Game.new with fischer random
  when "4"
    # quites
  end
end

def front_page
  print_logo

  print_options

  puts ""
  loop do
    print "             Enter the number for what you would like to do? "
    game = gets.chomp.downcase

    return game if %w[1 2 3].include?(game)
  end
end

def print_options # rubocop:disable Metrics/AbcSize
  puts "+-----+-----+-----+-----+-----+".center(54)
  puts "| 1 - Play a new game         |".center(54)
  puts "+-----+-----+-----+-----+-----+".center(54)
  puts "| 2 - Load a saved game       |".center(54)
  puts "+-----+-----+-----+-----+-----+".center(54)
  puts "| 3 - Play Fischer Random     |".center(54)
  puts "+-----+-----+-----+-----+-----+".center(54)
  puts "| 4 - Exit                    |".center(54)
  puts "+-----+-----+-----+-----+-----+".center(54)
end

def clear
  10.times do
    print "\e[1A\e[J"
    sleep 0.1
  end
end

play_chess
