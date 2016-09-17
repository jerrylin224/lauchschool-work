require 'pry'
SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i.zero? # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(cards)
  total(cards) > 21
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    "You busted! Dealer wins!"
  when :dealer_busted
    "Dealer busted! You win!"
  when :player
    "You win!"
  when :dealer
    "Dealer wins!"
  when :tie
    "It's a tie!"
  end
end

def determine_winner(dealer_cards, player_cards)
  result = display_result(dealer_cards, player_cards)
  if result.include?("You win!")
    :player
  elsif result.include?("Dealer wins!")
    :dealer
  end
end

def record_point!(dealer_cards, player_cards, score)

  winner = determine_winner(dealer_cards, player_cards) 
  if winner == :player
    score[:player] += 1
  elsif winner == :dealer
    score[:dealer] += 1
  end
end

#The reason why it is not working is because :dealer is an object,not string

def display_point
  prompt "Player point is #{score[player]},dealer point is #{score[dealer]}"
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

 
loop do
  prompt "Welcome to Twenty-One!"

  # initialize vars

    score = {
    player: 0,
    dealer: 0
  }

  # player turn
  loop do


    loop do
      deck = initialize_deck
      player_cards = []
      dealer_cards = []

      # initial deal
      2.times do
        player_cards << deck.pop
        dealer_cards << deck.pop
      end      
      loop do
        prompt "Dealer has #{dealer_cards[0]} and ?"
        prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}."
        player_turn = nil
        loop do
          prompt "Would you like to (h)it or (s)tay?"
          player_turn = gets.chomp.downcase
          break if ['h', 's'].include?(player_turn)
          prompt "Sorry, must enter 'h' or 's'."
        end

        if player_turn == 'h'
          player_cards << deck.pop
          prompt "You chose to hit!"
          prompt "Your cards are now: #{player_cards}"
          prompt "Your total is now: #{total(player_cards)}"
        end

        break if player_turn == 's' || busted?(player_cards)
      end

      player_total = total(player_cards)

      if busted?(player_cards)
        record_point!(dealer_cards, player_cards, score)
        prompt "Your point is #{score[:player]},dealer's point is #{score[:dealer]}"
        break
      else
        prompt "You stayed at #{player_total}"
      end

      
      prompt "Dealer turn..."

      loop do
        prompt "Dealer hits!"
        dealer_cards << deck.pop
        prompt "Dealer's cards are now: #{dealer_cards}"
        break if busted?(dealer_cards) || total(dealer_cards) >= 17
      end

      dealer_total = total(dealer_cards)
      loop do
        if busted?(dealer_cards)
          prompt "Dealer total is now: #{dealer_total}"
          prompt "You win!"
          prompt "Your point is #{score[:player]},dealer's point is #{score[:dealer]}"
          break
        else
          prompt "Dealer stays at #{dealer_total}"
        end
      end
      puts "=============="
      prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
      prompt "Player has #{player_cards}, for a total of: #{player_total}"
      puts "=============="

      prompt "#{display_result(dealer_cards, player_cards)}"
      record_point!(dealer_cards, player_cards, score)
      prompt "Your point is #{score[:player]},dealer's point is #{score[:dealer]}"
      break if score[:player] == 5 || score[:dealer] == 5
      prompt "Press enter to continue"
      gets
      system 'clear'
    end

   
  end
   break unless play_again?
 

  # dealer turn
end
 prompt "Thank you for playing Twenty-One! Good bye!"

#how to record point effectively?
