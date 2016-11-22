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
  attr_accessor :move, :name, :score, :history, :percentage, :personalities

  def initialize
    # binding.pry
    set_name
    self.score = Score.new
    @history = []
    @@human_percentage = ''
  end

  def move_choosen_percentage
    hash = {}
    self.history.each do |move|
      hash[move] = self.history.count(move).to_f / self.history.size
    end
    hash
  end

  def decide_personality(string)
    case string
    when 'R2D2'      then R2D2.new
    when 'Siri'      then Siri.new
    when 'The Thing' then TheThing.new
    end
  end


end

class Human < Player
  def set_name
    n = ''
    loop do
      RPSGame.clear_screen
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

    def human_percentage_over_50
    result = self.move_choosen_percentage.select do |move, percentage|
      percentage >= 0.6
    end
    # binding.pry
    @@human_percentage = result.keys.shuffle.first
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
    RPSGame.clear_screen
  end
end

class Computer < Player
  attr_accessor :personalities

  def set_name
    # binding.pry
    self.name = ['The Thing'].sample
    self.personalities = decide_personality(self.name) # R2D2.new
  end




  def choose
    # binding.pry
    # @personalities = decide_personality('R2D2')
    if @@human_percentage != nil
      self.move = Move.new(LOSING_CONDITION[@@human_percentage].sample)
    else
      # self.move = Move.new(Move::VALUES.sample)
      # binding.pry
      self.move = Move.new(self.personalities.default)
    end
    self.history << self.move.value
  end
end

class R2D2 < Computer
  def initialize
    # @personalities = ''
  end

  def default
    case rand(1..6)
    when (1..3) then 'rock'
    when (4..5) then 'paper'
    else             'scissors'
    end
  end
end

class Siri < Computer
  def initialize
    # @personalities = ''
  end

  def default
    case rand(1..6)
    when (1..3) then 'spock'
    when (4..5) then 'rock'
    else             'scissors'
    end
  end
end

class TheThing < Computer
  def initialize
    # @personalities = ''
  end
  def default
    'rock'
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

  def self.clear_screen
    system('clear')
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
# 所以問題是出在沒有initialize?