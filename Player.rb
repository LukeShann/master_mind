require_relative "screen"

class Player
end

class HumanPlayer < Player
  def make_code
    puts 'human making code'
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
  end
end