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
    @code = @player_one.choose_code
    until @game_won || @history.length >= 12 do
      guess = @player_two.guess(history)
      score = evalute_guess(guess)
      @history.push({:guess => guess, :score => score})
      print_board(@history)
    end
    if @game_won
      print_message('Winner!')
      return
    end
    print_message('No more turns!')
  end

  def evalute_guess(guess)
    @game_won = true if guess == @code
    score_guess(guess, @code)
  end

  def score_guess(guess, code)
    score = [0, 0]
    guess.each_with_index do |digit, i|
      if digit == code[i]
        score[0] += 1
        next
      end
      score[1] += 1 if code.include?(digit)
    end
    score
  end

  def player_setup
    print_message(
      "Would you like to guess the code or write the code?",
      "Enter 1 to write the code or 2 to guess"
    )
    loop do
      choice = gets.chomp.to_i
      if choice == 1 then
        @player_one = HumanPlayer.new('You')
        @player_two = ComputerPlayer.new('Computer', self)
        print_message("You will be choosing")
        break
      elsif choice == 2 then
        @player_one = ComputerPlayer.new('Computer', self)
        @player_two = HumanPlayer.new('You')
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
