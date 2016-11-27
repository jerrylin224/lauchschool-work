OPTIONS = %w(rock scissors paper lizard spock).freeze

WINNING_CONDITION = {
  'rock' => %w(scissors lizard), 'paper' => %w(rock spock),
  'scissors' => %w(paper lizard), 'lizard' => %w(spock paper),
  'spock' => %w(rock scissors)
}.freeze

LOSING_CONDITION = {
  'rock' => %w(paper spock), 'paper' => %w(scissors lizard),
  'scissors' => %w(rock spock), 'lizard' => %w(scissors rock),
  'spock' => %w(lizard paper)
}.freeze

SHORT_CUT = {
  'r' => 'rock', 'p' => 'paper', 's' => 'scissors', 'li' => 'lizard',
  'sp' => 'spock'
}.freeze

class History
  attr_reader :value

  def initialize
    @value = { human: [], computer: [] }
  end

  def [](key)
    @value[key]
  end

  def to_s
    @value
  end
end

class Move
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def >(other_move)
    WINNING_CONDITION[value].include?(other_move.value)
  end

  def <(other_move)
    other_move > self
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize(history)
    @history = history
  end

  def move_percentage(player)
    move_history = history.value[player]
    result = move_history.uniq.select do |move|
      move_history.count(move).to_f / move_history.size >= 0.5
    end
    result.sample
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      puts "Choose your move (r)for Rock, (s)scissors, (p)for paper, " \
      "(li)for lizard, and  (sp)for spock"
      choice = gets.chomp.downcase
      break if SHORT_CUT.keys.include? choice
      puts "Sorry, must be a valid choice"
    end
    self.move = Move.new(SHORT_CUT[choice])
  end
end

class Computer < Player
  def initialize(history)
    super
    set_name
  end

  def inteligence
    case set_name
    when 'R2D2'    then R2D2.new
    when 'Siri'    then Siri.new
    when 'Whatson' then Whatson.new
    end
  end

  def choose
    if !move_percentage(:human).nil?
      self.move = Move.new(LOSING_CONDITION[move_percentage(:human)].sample)
    else
      self.move = Move.new(inteligence.value)
    end
  end

  def set_name
    self.name = %w(R2D2 Whatson Siri).sample
  end
end

class R2D2
  attr_accessor :value

  def initialize
    set_value
  end

  def set_value
    self.value = case rand(1..10)
                 when 1..5 then 'paper'
                 when 6..9 then 'rock'
                 when 10   then 'scissors'
                 end
  end
end

class Siri
  attr_accessor :value

  def initialize
    set_value
  end

  def set_value
    self.value = case rand(1..10)
                 when 1..2  then 'lizard'
                 when 3..4  then 'spock'
                 when 5..6  then 'rock'
                 when 7..10 then 'scissors'
                 end
  end
end

class Whatson
  attr_accessor :value

  def initialize
    set_value
  end

  def set_value
    self.value = case rand(1..10)
                 when 1..4 then 'lizard'
                 when 5..8 then 'spock'
                 when 10   then 'paper'
                 end
  end
end

class RPSGame
  attr_accessor :human, :computer, :history, :max_point

  def initialize
    history = History.new
    @human = Human.new(history)
    @computer = Computer.new(history)
    @max_point = 0
  end

  def display_welcome_message
    puts "Welcome to Rock, Scissors, Paper, Lizard, Spock."
  end

  def ask_player_name
    answer = nil
    loop do
      puts "What's your name?"
      answer = gets.chomp
      break unless answer.empty?
      puts "Sorry, must type a value"
    end
    human.name = answer
  end

  def display_goodbye_message
    clear_screen
    split_line(" SAYING GOODBYE ")
    puts "Thanks for playing Rock, Scissors, Paper, Lizard, Spock. Goodbye."
  end

  def display_move
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    puts ""
  end

  def decide_winner
    if human.move > computer.move
      :win
    elsif human.move < computer.move
      :lose
    else
      :tie
    end
  end

  def update_score
    case decide_winner
    when :win  then human.score += 1
    when :lose then computer.score += 1
    end
  end

  def ask_for_stop_point
    answer = nil
    loop do
      puts "How many scores should we play until?"
      answer = gets.chomp
      break if !(answer =~ /[\D|0]/)
      puts "Sorry, must be an integer greater than 1."
    end
    self.max_point = answer.to_i
    puts "Ok, let's play #{max_point}"
  end

  def display_score
    case decide_winner
    when :win
      puts "#{human.name} got #{human.score} scores"
    when :lose
      puts "#{computer.name} got #{computer.score} scores"
    when :tie
      puts "No noe got score"
    end
  end

  def display_winner
    case decide_winner
    when :win  then puts "You won this round!"
    when :lose then puts "Computer won this round!"
    when :tie  then puts "It's a tie"
    end
  end

  def human_match_max_point?
    human.score == max_point
  end

  def computer_march_max_point?
    computer.score == max_point
  end

  def match_stop_point?
    human_match_max_point? || computer_march_max_point?
  end

  def display_final_winner
    split_line(" GAME RESULT ")
    puts ""
    if human_match_max_point?
      puts "#{human.name} are the game winner!"
    elsif computer_march_max_point?
      puts "#{computer.name} is the game winner!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be a valid answer."
    end
    answer == 'y'
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def clear_screen
    system 'clear'
  end

  def split_line(string)
    puts ""
    puts string.center(38, '-')
  end

  def game_result_split_line
    puts ""
    puts "------------ GAME RESULT -------------"
  end

  def press_to_next_round
    split_line("")
    puts "Press enter to continue; type (q) to quit; type (h) for history."
    answer = gets.chomp
    case answer
    when 'q' then 0
    when 'h' then display_history
    else          1
    end
  end

  def display_recored_score
    puts "#{human.name} got: #{human.score}. Copmuter got: #{computer.score}."
    puts "#{max_point - [human.score, computer.score].max} scores to go."
    puts ""
  end

  def update_move_history
    human.history[:human] << human.move.value
    computer.history[:computer] << computer.move.value
  end

  def display_history
    clear_screen
    split_line(' GAME HISTORY ')
    puts "Human: #{human.history.value[:human]}"
    puts "Computer: #{computer.history.value[:computer]}"
    press_to_next_round
  end

  def welcom_the_player
    clear_screen
    split_line(" WELCOME ")
    display_welcome_message
    ask_player_name
  end

  def ask_for_typing_score
    clear_screen
    split_line(" TYPE A SCORE ")
    ask_for_stop_point
    reset_score
  end

  def game_message
    split_line(" ROUND RESULT ")
    update_score
    display_recored_score
    display_move
    display_winner
    display_score
    update_move_history
    human.move_percentage(:human)
  end

  def plyer_choose
    computer.choose
    human.choose
  end

  def score_information
    clear_screen
    split_line(" GAME START ")
    display_recored_score
    plyer_choose
    clear_screen
  end

  def play
    welcom_the_player
    loop do
      ask_for_typing_score
      loop do
        score_information
        game_message
        break if match_stop_point? || press_to_next_round.zero?
      end
      display_final_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
