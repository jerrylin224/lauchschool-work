require 'pry'
VALID_CHOICE = %w(paper scissors rock lizard spock)

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
    (first == "scissors" && second == "paper") ||
    (first == "paper" && second == "rock") ||
    (first == "rock" && second == "lizard") ||
    (first == "lizard" && second == "spock") ||
    (first == "spock" && second == "scissors") ||
    (first == "scissors" && second == "lizard") ||
    (first == "lizard" && second == "paper") ||
    (first == "paper" && second == "spock") ||
    (first == "spock" && second == "rock") ||
    (first == "rock" && second == "scissors") 
end

def display_point(point)
  prompt "Your point is #{point['player']},computer point is #{point['computer']}"
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
  if point['player'] == 5 || point['computer'] == 5
    true
  end  
end

def play_again?(point)
  answer = ''
    loop do
      prompt "Do you want to play again?Type y or n"
      answer = gets().chomp().downcase
      break if %w(y n).include?(answer)
      prompt "You should type y or n"
    end
    if answer == 'n'
      true
    end
end

loop do
  point = {
    'computer' => 0,
    'player' => 0
  }
  loop do
    choice = ''
    loop do
      system 'clear'
      prompt("Type the first two letter to chose:#{VALID_CHOICE.join(', ')}")
      choice = gets().chomp()

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
    break if winning_point_reach?(point)
    end
  break if play_again?(point)
end

prompt("Thanks for playing,good bye.")
