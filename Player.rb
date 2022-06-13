require_relative "screen"

class Player
  include Screen
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def is_valid_code?(code)
    return false if code.length != 4
    return false if code.uniq.length != 4
    code.all? { |digit| (1..6).include?(digit) }
  end
end

class HumanPlayer < Player
  def guess(_)
    get_code
  end

  def choose_code
    get_code
  end

  def get_code
    print_message("Enter 4 unique digits")
    code = []
    until is_valid_code?(code) do
      code = gets.chomp.split('')
      code.map!(&:to_i)
    end
    code
  end

end

class ComputerPlayer < Player
  def guess(history)
    # AI goes here
    make_code
  end

  def choose_code
    print_message("Computer has selected a code")
    make_code
  end

  def make_code
    code = []
    4.times do
      loop do
        digit = rand(6) + 1
        unless code.include? digit
          code.push(digit)
          break
        end
      end
    end
    code
  end
end