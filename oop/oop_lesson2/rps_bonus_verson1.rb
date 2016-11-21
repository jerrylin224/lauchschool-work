require 'pry'
WINNING_CONDITION = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'spock' => %w(rock scissors),
  'lizard' => %w(paper spock)
}

LOSING_CONDITION = {
  'rock' => %w(paper spock),
  'paper' => %w(scissors lizard),
  'scissors' => %w(rock spock),
  'spock' => %w(paper lizard),
  'lizard' => %w(scissors spock)
}
class Score
  attr_accessor :value

  def initialize
    @value = 0
  end

  def increment_score
    @value += 1
  end
end

class Move
  attr_accessor :value
  VALUES = ['rock', 'scissors', 'paper', 'lizard', 'spock'].freeze

  def initialize(value)
    @value = value
  end
  def to_s
    @value
  end

  def >(other_choice)
    WINNING_CONDITION[value].include?(other_choice.value)
  end

  def <(other_choice)
    WINNING_CONDITION[other_choice.value].include?(value)
  end
end

class Player
  attr_accessor :move, :name, :score, :history, :percentage
  def initialize
    set_name
    self.score = Score.new
    @history = []
    @@human_percentage = 0
  end

  def move_choosen_percentage
    hash = {}
    self.history.each do |move|
      hash[move] = self.history.count(move).to_f / self.history.size
    end
    hash
  end


end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

    def human_percentage_over_50
    result = self.move_choosen_percentage.select do |move, percentage|
      percentage >= 0.5
    end
    @@human_percentage = result.keys.first
  end

  def choose
    human_percentage_over_50
    choice = ''
    loop do
      puts "Please choose rock, scissors, paper, scissors or spock."
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
    self.history << self.move.value
  end
end

class Computer < Player
  def set_name
    self.name = ['a', 'b', 'c'].sample
  end

  def choose
    if @@human_percentage != nil
      self.move = Move.new(LOSING_CONDITION[@@human_percentage].sample)
    else
      self.move = Move.new(Move::VALUES.sample)
    end
    self.history << self.move.value
  end
end

class RPSGame
  attr_accessor :human, :computer, :score

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing."
  end

  def player_choice
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def decide_round_winner
    if human.move > computer.move
      :human
    elsif human.move < computer.move
      :computer
    else
      :tie
    end
  end

  def display_winner
    player_choice
    case decide_round_winner
    when :human then puts "#{human.name} won!"
    when :computer then puts "#{computer.name} won!"
    when :tie then puts "It's a tie!"
    end
  end


  def update_score
    case decide_round_winner
    when :human then human.score.increment_score
    when :computer then computer.score.increment_score
    end
  end

  def reach_winning_score?
    !!final_winner
  end

  def show_score
    puts "#{human.name} got #{human.score.value} score."
    puts "#{computer.name} got #{computer.score.value} score"
  end

  def final_winner
    if human.score.value == 5 || computer.score.value == 5
      human.score.value == 5 ? :human : :computer
    end
  end

  def display_final_winner_score
    puts "#{final_winner} got 5 points, #{final_winner} won!"
  end

  def play_again?
    display_final_winner_score
    puts "Would you like to play again? (y/n)"
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n"
    end
    return true if answer == 'y'
    false
  end

  def show_history
    puts "#{human.history}"
    puts "#{computer.history}"
  end

  def show_percentage
    human.move_choosen_percentage
    puts "#{human.percentage}"
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_winner
        update_score
        show_score
        show_history
        break if reach_winning_score?
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

# keeping score，ask play again if someone reach 10 points.
# 只要滿足這個條件就算成立

# 條件：human 某拳種出現機率大於50%就針對攻擊