require_relative "screen"

class Game
  include Screen
  attr_reader :history

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
      print_message("#{@player_two.name} Wins!")
      return
    end
    print_message(
      "No more turns!",
      "#{@player_one.name} Wins!")
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

  private

  def evalute_guess(guess)
    @game_won = true if guess == @code
    score_guess(guess, @code)
  end

  def welcome
    Screen.clear
    print_message(
      "Welcome to MasterMind!",
      "Guess the opponent's 4 digit code within 12 guesses to win",
      "Each digit will be a number between 1 and 6")
    print_message(
      "Scoring",
      "One ● for each correct digit in the correct place",
      "One ○ for each correct digit in the wrong place",
    )
  end

  def player_setup
    print_message(
      "Play against computer or another player?",
      "Enter 1 for computer or 2 for another player"
    )
    choice = 0
    choice = gets.chomp.to_i until choice == 1 || choice == 2
    Screen.clear
    if choice == 1 then
      print_message(
        "Would you like to guess the code or write the code?",
        "Enter 1 to write the code or 2 to guess"
      )
      choice = 0
      choice = gets.chomp.to_i until choice == 1 || choice == 2
      Screen.clear
      if choice == 1
        @player_one = HumanPlayer.new('Player One', 'Choose')
        @player_two = ComputerPlayer.new('Computer', 'Guess', self)
      end
      if choice == 2 then
        @player_one = ComputerPlayer.new('Computer', 'Choose', self)
        @player_two = HumanPlayer.new('Player One', 'Guess')
      end
    else
      @player_one = HumanPlayer.new('Player One', 'Choose')
      @player_two = HumanPlayer.new('Player Two', 'Guess')
    end
  end
end
