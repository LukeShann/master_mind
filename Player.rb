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
  def initialize(name)
    @name = name
    @sets = populate_set
  end
  
  def guess(history)
    return @sets.sample if history.empty?
    
  end
  
  def choose_code
    print_message("Computer has selected a code")
    make_code
  end
  
  def populate_set
    sets = []
    combinations = (1..6).to_a.combination(4).to_a
    combinations.each do |set|
      combo = []
      4.times do |first| # four times, indexes 0 - 3
        combo[0] = set[first]
        4.times do |second| # three times, each index that isn't first
          next if second == first
          combo[1] = set[second]
          4.times do |third| # twice, each index that isn't first or second
            next if third == first || third == second
            combo[2] = set[third]
            4.times do |fourth| # once, with the only index left
              next if fourth == first || fourth == second || fourth == third
              combo[3] = set[fourth]
              sets.push(combo)
            end
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