module Screen
  SCREEN_WIDTH = 80

  def self.clear
    print "\e[2J\e[f"
  end

  def print_message(*args)
    SCREEN_WIDTH.times { print '=' }
    puts ''
    args.flatten.each { |message| print_message_line(message) }
    SCREEN_WIDTH.times { print '=' }
    puts "\n\n"
  end

  def print_board(history)
    Screen.clear
    board = []
    history.each { |set| board.push("#{set[:guess].join(' ')} -> #{translate_score(set[:score])}") }
    print_message(board)
  end

  private

  def print_message_line(content)
    margin = (SCREEN_WIDTH - content.length) / 2 - 2
    print "="
    margin.times { print ' ' }
    print " #{content} "
    (margin + content.length % 2).times { print ' ' }
    puts "="
  end

  def translate_score(score)
    str = ' '
    score[0].times { str += '● ' }
    score[1].times { str += '○ ' }
    str += ' ' while str.length < 9
    str
  end
end
