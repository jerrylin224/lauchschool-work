require 'pry'
VALID_CHOICE = %w(paper scissors rock lizard spock)
WINNING_CONDITION = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'spock' => %w(rock scissors),
  'lizard' => %w(paper spock)
}

def prompt(message)
  puts "=> #{message}"
end

def win?(player, computer)
  WINNING_CONDITION[player].include?(computer)
end

def display_point(point)
  prompt "Your point is #{point['player']}," \
  "computer point is #{point['computer']}"
end

def display_result(player, computer)
  if win?(player, computer)
    "You win!"
  elsif win?(computer, player)
    "Computer win!"
  else
    "It's a tie!"
  end
end

def update_point(player, computer, point)
  if display_result(player, computer).start_with?('Y')
    point['player'] += 1
  elsif display_result(player, computer).start_with?('C')
    point['computer'] += 1
  end
end

def winning_point_reach?(point)
  true if point['player'] == 5 || point['computer'] == 5
end

def play_again?
  answer = ''
  loop do
    prompt "Do you want to play again?Type y or n"
    answer = gets().chomp().downcase
    break if %w(y n).include?(answer)
    prompt "You should type y or n"
  end
  true if answer == 'n'
end

def display_winner(point)
  if point['player'] == 5
    prompt "You won!"
  elsif point['computer'] == 5
    prompt "Comoputer won!"
  end
end

def input_choice(word)
  if word == 'r' then 'rock'
  elsif word == 'p' then 'paper'
  elsif word == 'sc' then 'scissors'
  elsif word == 'l' then return 'lizard'
  elsif word == 'sp' then return 'spock'
  end
end

loop do
  point = {
    'computer' => 0,
    'player' => 0
  }
  prompt "Welcome to rock paper scissors lizard spock." \
  "Who gets 5 points,who wins."
  loop do
    choice = ''
    loop do
      player_choice_prompt = <<-MSG
Choose one to play:
    r for rock
    p for paper
    sc for scissors
    l for lizard
    sp for spock
  MSG
      prompt(player_choice_prompt)
      choice = input_choice(gets.chomp)
      if VALID_CHOICE.include?(choice)
        break
      else
        prompt("Please input a valid choice.")
      end
    end
    computer_choice = VALID_CHOICE.sample
    prompt("You chose: #{choice} ;Computer chose: #{computer_choice}")
    prompt display_result(choice, computer_choice)
    update_point(choice, computer_choice, point)
    display_point(point)
    prompt "Press enter to continue"
    gets
    system 'clear'
    break if winning_point_reach?(point)
  end
  display_winner(point)
  break if play_again?
end

prompt("Thanks for playing,good bye.")
