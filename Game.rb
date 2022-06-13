module Screen
  def self.clear
      print "\e[2J\e[f"
  end
end

class Game
  include Screen
  attr_accessor :player_1, :player_2
  attr_reader :screen_width

  def initialize
    @screen_width = 80
  end

  def play_game
    welcome
    player_setup
  end

  def player_setup

  end

  def welcome
    Screen.clear
    print_message(
      "Welcome to MasterMind!",
      "Guess the opponent's 4 digit code within 12 guesses to win",
      "Each digit will be a number between 1 and 6"
    )
  end

  def print_message(*args)
    @screen_width.times { print '=' }
    puts ''
    args.each { |message| print_message_line(message) }
    @screen_width.times { print '=' }
    puts "\n\n"
  end

  def print_message_line(content)
    margin = (@screen_width - content.length) / 2 - 1
    margin.times { print '=' }
    print " #{content} "
    (margin + content.length % 2).times { print '=' }
    print "\n"
  end
end
