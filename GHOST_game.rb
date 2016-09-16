#!/usr/bin/env ruby
class Game
  attr_accessor :fragment, :dictionary, :current_player, :previous_player,
  :losses, :record

  def initialize
    @fragment = ""
    @dictionary = {}
    File.foreach("dictionary.txt") do |line|
      @dictionary[line.chomp] = nil
    end
    @current_player = Player.new("Player One")
    @previous_player = Player.new("Player Two")

  end


  def play
    play_round until lost?
    puts "#{current_player.name}, you completed the word #{fragment}!"
  end

  def play_round
    puts "So far: #{@fragment}"
    take_turn(current_player)

    next_player!
  end

  def get_guess
    puts "Guess a letter."
    gets.chomp
  end



  def take_turn(player)
    test = fragment + get_guess
    until valid_play?(test)
      puts "No words beginning with '#{test}'
       found in my dictionary!"
      puts "So far: #{@fragment}"
      test = fragment + get_guess
    end

    @fragment = test
  end

  def valid_play?(string)
    dictionary.keys.any? {|word| word[0...string.length] == string}
  end

  def next_player!
    @current_player, @previous_player = previous_player, current_player
  end

  def lost?
    dictionary.keys.include?(@fragment)
  end
end

class Player
  attr_accessor :name, :losses, :record

  def initialize(name)
    @name = name
    @losses = 0
    @record = ""
  end

  def guess
  end

  def alert_invalid_guess
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play_round
end
