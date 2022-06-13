require_relative "screen"

class Game
  include Screen
  attr_accessor :player_one, :player_two, :code, :history, :game_won

  def initialize
    @history = []
    @code = []
    @game_won = false
  end

  def play_game
    welcome
    player_setup
    @code = @player_one.make_code
    until @game_won do
      guess = @player_two.guess
      score = evalute_guess(guess)
      @history.push({:guess => guess, :score => score})
      print_board(@history)
      @game_won = true
    end
  end

  def evalute_guess(guess)
    @game_won = true if guess == @code
    # return array of two numbers to indicate black & white pegs to be interpreted by print_board
    score = [0, 0]
    
  end

  def player_setup
    print_message(
      "Would you like to guess the code or write the code?",
      "Enter 1 to write the code or 2 to guess"
    )
    loop do
      choice = gets.chomp.to_i
      if choice == 1 then
        @player_one = HumanPlayer.new('Player 1')
        @player_two = ComputerPlayer.new('Player 2')
        print_message("You will be choosing")
        break
      elsif choice == 2 then
        @player_one = ComputerPlayer.new('Player 1')
        @player_two = HumanPlayer.new('Player 2')
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
