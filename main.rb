require_relative "lib/board"
require_relative "lib/game"
require_relative "lib/player"
require "colorize"

def print_logo
  puts ""
  puts "   ______"
  puts "  / ___| |__   ___  ___ ___"
  puts " | |   | '_ \ / _ \/ __/ __|"
  puts ' | |___| | | |  __/\__ \__ \ '
  puts '  \____|_| |_|\___||___/___/'
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

def play_chess
  print_logo

  # names = setup_players
  # new_game = Game.new(names[0], names[1])
  new_game = Game.new
  new_game.play_game
end

play_chess
