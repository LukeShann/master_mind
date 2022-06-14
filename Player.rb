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
  def initialize(name, game)
    @name = name
    @game = game
    @sets = populate_set
  end
  
  def guess(history)
    sleep(0.5)
    return @sets.sample if history.empty?
    return @sets.sample if rand(10) < 6
    @sets = @sets.select { |set| 
      @game.score_guess(history.last[:guess], set) == history.last[:score]
    }
    @sets.sample
  end
  
  def choose_code
    print_message("Computer has selected a code")
    make_code
  end
  
  def populate_set
    sets = []
    combinations = (1..6).to_a.combination(4).to_a
    combinations.each do |arr|
      4.times do |first|
        3.times do |second|
          2.times do |third|
            combo = []
            set = arr.dup
            combo[0] = set.delete_at(first)
            combo[1] = set.delete_at(second)
            combo[2] = set.delete_at(third)
            combo[3] = set.delete_at(0)
            sets.push(combo) unless sets.include?(combo)
          end
        end
      end
    end
    sets
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