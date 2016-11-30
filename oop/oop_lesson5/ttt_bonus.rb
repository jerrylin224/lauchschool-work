class Board
  attr_reader :squares, :marker
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](num)
    @squares[num]
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def find_at_risk_square(brd, marker)
    WINNING_LINES.each do |line|
      squares_in_line = brd.squares.values_at(*line)
      next unless squares_in_line.collect(&:marker).count(marker) == 2 &&
                  squares_in_line.select(&:unmarked?).count == 1
      square_num = line.select do |num|
        brd.squares[num].marker == Square::INITIAL_MARKER
      end
      return square_num.first
    end
    nil
  end

  def place_center
    5 if @squares[5].marker == Square::INITIAL_MARKER
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Marker
  attr_accessor :value

  def initialize
    @value = { human: ' ', computer: ' ' }
  end

  def [](key)
    @value[key]
  end

  def []=(key, mark)
    @value[key] = mark
  end
end

class Player
  attr_accessor :score, :name, :marker

  def initialize(marker)
    @marker = marker
    @name = nil
  end
end

class Human < Player
  def move(brd)
    puts "Choose a square (#{joinor(brd.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if brd.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    brd[square] = marker.value[:human]
  end

  def joinor(arr, delimiter=', ', word='or')
    arr[-1] = "#{word} #{arr.last}" if arr.size > 1
    arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
  end
end

class Computer < Player
  COMPUTER_NAME = ['Alphago', 'Deep Blue', 'Skynet'].freeze

  def initialize(marker)
    super
    @name = COMPUTER_NAME.sample
  end

  def move(brd)
    square = brd.find_at_risk_square(brd, marker.value[:computer]) ||
             brd.find_at_risk_square(brd, marker.value[:human]) ||
             brd.place_center ||
             brd.unmarked_keys.sample

    brd[square] = marker.value[:computer]
  end
end

module PlayerQuestions
  def set_player_settings
    reset_score
    decide_computer_marker
    ask_for_max_score
    ask_who_goes_first
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def ask_for_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Sorry, you must enter a name."
    end
    puts ""
    human.name = name
  end

  def decide_computer_marker
    computer.marker.value[:computer] = if ask_for_player_marker == 'X'
                                         'O'
                                       else
                                         'X'
                                       end
  end

  def ask_for_player_marker
    puts "What would you like your marker to be? (1) for 'X', (2) for 'O'"
    answer = nil
    loop do
      answer = gets.chomp
      break if %w(1 2).include? answer
      puts "Sorry, must type 1 or 2."
    end
    human.marker.value[:human] = if answer == 1
                                   'X'
                                 else
                                   'O'
                                 end
  end

  def ask_for_max_score
    puts "How many points should we play until?"
    points = nil
    loop do
      points = gets.chomp
      break if !(points =~ /[\D|0]/)
      puts "Sorry, please enter an integer greater than 0."
    end
    puts ""
    @winning_score = points.to_i
  end

  def ask_who_goes_first
    answer = nil
    loop do
      puts "#{human.name}, would you like to go first or last? (f) for first, "\
      "(l) for last, and (r) for random."
      answer = gets.chomp.downcase
      break if %w(f l r).include? answer
      puts "Sorry, must be a valid choice"
    end
    @current_marker = decide_who_goes_first(answer)
    @recorded_marker = @current_marker
  end

  def decide_who_goes_first(answer)
    case answer
    when 'f' then human.marker.value[:human]
    when 'l' then computer.marker.value[:computer]
    when 'r' then human.marker.value.keys.sample
    end
  end
end

module DisplayGameMessage
  def display_result
    case board.winning_marker
    when human.marker.value[:human]       then puts "You won!"
    when computer.marker.value[:computer] then puts "#{computer.name} won!"
    else                                       puts "It's a tie!"
    end
    display_next_round_message
  end

  def display_next_round_message
    puts "Press enter to start the next round."
    answer = gets.chomp
  end

  def display_play_again_message
    reset
    puts "Let's play again!"
    puts ""
  end

  def display_finnal_winner
    system "clear"
    if human_win?
      puts "#{human.name} reached the winning score."
      puts "#{human.name} is the fianl winner!"
    else
      puts "#{computer.name} reached the winning score."
      puts "#{computer.name} is the finnal winner!"
    end
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
    puts ""
    ask_for_name
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_score_information
    puts "You're a #{human.marker.value[:human]}. #{computer.name} "\
      "is a #{computer.marker.value[:computer]}."
    puts "You got #{human.score} scores. #{computer.name} got"\
      " #{computer.score} scores."
  end

  def display_board
    display_score_information
    display_how_many_score_left
    puts ""
    board.draw
    puts ""
  end

  def display_how_many_score_left
    puts "#{@winning_score - [human.score, computer.score].max}"\
     "scores to go."
  end
end

class TTTGame
  include PlayerQuestions
  include DisplayGameMessage

  attr_reader :board, :human, :computer

  def initialize
    marker = Marker.new
    @board = Board.new
    @human = Human.new(marker)
    @computer = Computer.new(marker)
  end

  def play
    display_welcome_message
    loop do
      set_player_settings
      loop do
        board_setting
        play_one_round
        display_result
        break if match_winning_point?
      end
      display_finnal_winner
      break unless play_again?
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def board_setting
    reset
    @current_marker = @recorded_marker
    display_board
  end

  def play_one_round
    loop do
      current_player_moves
      update_score
      clear_screen_and_display_board
      break if board.someone_won? || board.full?
    end
  end

  def human_turn?
    @current_marker == human.marker.value[:human]
  end

  def current_player_moves
    if human_turn?
      human.move(board)
      @current_marker = computer.marker.value[:computer]
    else
      computer.move(board)
      @current_marker = human.marker.value[:human]
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "#{human.name}, would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end

    answer == "y"
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
  end

  def match_winning_point?
    human_win? || computer_win?
  end

  def human_win?
    human.score == @winning_score
  end

  def computer_win?
    computer.score == @winning_score
  end

  def update_score
    case board.winning_marker
    when human.marker.value[:human]
      human.score += 1
    when computer.marker.value[:computer]
      computer.score += 1
    end
  end
end

game = TTTGame.new
game.play
