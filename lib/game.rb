# All game functions for turns, rounds, wins, losses
require_relative './player.rb'

class Game
  attr_reader :players
  MIN_PLAYERS = 2
  MAX_PLAYERS = 4
  DICTIONARY = File.read('dictionary.txt').split(/\n+/).product([nil]).to_h
  LOSING_TEXT = 'GHOST'.freeze

  def initialize(num_players)
    # Make player objects
    num_players = Game.validate_num_players(num_players)
    @players = []
    Game.create_players(num_players, @players)
    # Track scores & word fragment
    @scores = @players.map { |player| [player.name, ''] }.to_h
    @fragment = ''
  end

  def self.validate_num_players(num_players)
    while !(MIN_PLAYERS..MAX_PLAYERS).include?(num_players)
      puts "Please enter a number between #{MIN_PLAYERS} and #{MAX_PLAYERS}."
      num_players = gets.chomp.to_i
    end
    num_players
  end

  def self.create_players(num_players, players)
    num_players.times do |num|
      puts "Player #{num + 1} name:"
      players << Player.new(gets.chomp)
    end
  end

  def fragment_is_word?(fragment)
    DICTIONARY.key?(fragment)
  end

  def valid_fragment?(fragment)
    DICTIONARY.each_key do |word|
      return true if word[0...fragment.length] == fragment
    end
    false
  end

  def round
    turns = 0

  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new(3)
  p game.players
  p game.fragment_is_word?('guess')
  p game.fragment_is_word?('123')
  p game.valid_fragment?('gu')
  p game.valid_fragment?('3')
end