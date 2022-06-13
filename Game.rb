module Screen
  def self.clear
      print "\e[2J\e[f"
  end
end

class Game
  include Screen
  attr_accessor :player_1, :player_2, :code, :guesses
  SCREEN_WIDTH = 80

  def initialize
    @guesses = []
    @code = []
  end

  def play_game
    welcome
    player_setup
  end

  def player_setup
    print_message(
      "Would you like to guess the code or write the code?",
      "Enter 1 to write the code or 2 to guess"
    )
    loop do
      choice = gets.chomp
      if choice == 1 then
        player_1 = HumanPlayer.new
        player_2 = ComputerPlayer.new
      end
    end

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
    SCREEN_WIDTH.times { print '=' }
    puts ''
    args.each { |message| print_message_line(message) }
    SCREEN_WIDTH.times { print '=' }
    puts "\n\n"
  end

  def print_message_line(content)
    margin = (SCREEN_WIDTH - content.length) / 2 - 1
    margin.times { print '=' }
    print " #{content} "
    (margin + content.length % 2).times { print '=' }
    print "\n"
  end
end
