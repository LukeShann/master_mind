require_relative "screen"

class Player
  include Screen
end

class HumanPlayer < Player
  def make_code
    def is_valid?(code)
      return false if code.length != 4
      return false if code.uniq.length != 4
      code.all? { |digit| (1..6).include?(digit) }
    end

    print_message("Enter a 4 digit code")
    code = []
    until is_valid?(code) do
      code = gets.chomp.split('')
      code.map!(&:to_i)
    end
    code
  end

end

class ComputerPlayer < Player
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
    print_message("Computer has selected a code")
  end
end