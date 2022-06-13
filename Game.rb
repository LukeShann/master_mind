require_relative "screen"

class Game
  include Screen
  attr_accessor :player_1, :player_2, :code, :guesses, :won

  def initialize
    @guesses = []
    @code = []
    @won = false
  end

  def play_game
    welcome
    player_setup
    @code = @player_1.make_code
  end

  def player_setup
    print_message(
      "Would you like to guess the code or write the code?",
      "Enter 1 to write the code or 2 to guess"
    )
    loop do
      choice = gets.chomp.to_i
      if choice == 1 then
        @player_1 = HumanPlayer.new
        @player_2 = ComputerPlayer.new
        print_message("You will be choosing")
        break
      elsif choice == 2 then
        @player_1 = ComputerPlayer.new
        @player_2 = HumanPlayer.new
        print_message("You will be guessing")
        break
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
end
