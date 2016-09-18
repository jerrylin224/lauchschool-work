require 'pry'
SUITS = %w(H D S C).freeze
VALUES = %w(2 3 4 5 6 7 8 9 10 A J K Q).freeze
MAX_POINTS = 21
DEALER_STAY_POINTS = 17
WINNING_SCORE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i.zero?
             10
           else
             value.to_i
           end
  end

  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > MAX_POINTS
  end

  sum
end

def busted?(cards)
  total(cards) > MAX_POINTS
end

def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > MAX_POINTS
    :player_busted
  elsif dealer_total > MAX_POINTS
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
  if result.include?('You win!')
    :player
  elsif result.include?('Dealer wins!')
    :dealer
  end
end

def record_score!(dealer_cards, player_cards, score)
  winner = determine_winner(dealer_cards, player_cards)
  if winner == :player
    score[:player] += 1
  elsif winner == :dealer
    score[:dealer] += 1
  end
end

def display_score!(score)
  prompt "Player score is #{score[:player]},dealer score is #{score[:dealer]}"
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def display_winner(score)
  if score[:player] == WINNING_SCORE
    prompt "You got 5 scores,good game!"
  elsif score[:dealer] == WINNING_SCORE
    prompt "Dealer got 5 scores,sorry."
  end
end

loop do
  prompt "Welcome to Twenty-One!"
  score = {
    player: 0,
    dealer: 0
  }
  prompt "Your score is #{score[:player]},dealer score is #{score[:dealer]}"

  loop do
    player_cards = []
    dealer_cards = []

    loop do
      deck = initialize_deck
      2.times do
        player_cards << deck.pop
        dealer_cards << deck.pop
      end

      prompt "Dealer has #{dealer_cards[0]} and ?"
      prompt "You have: #{player_cards}, for a total of #{total(player_cards)}."

      loop do
        answer = ''
        loop do
          prompt "You want to (h)it ot (s)tay?"
          answer = gets.chomp
          break if ['h', 's'].include?(answer)
          prompt "Sorry,I don't understand..."
        end

        if answer == 'h'
          prompt "You got a new card."
          player_cards << deck.pop
          prompt "You have: #{player_cards},and a total of #{total(player_cards)}."
          break if busted?(player_cards)
        end

        break if answer == 's'
      end

      if busted?(player_cards)
        prompt "#{display_result(dealer_cards, player_cards)}"
        break
      end

      prompt "Dealer turn..."

      loop do
        prompt "Dealer has #{dealer_cards},and a total of #{total(dealer_cards)}"
        if busted?(dealer_cards)
          break
        elsif total(dealer_cards) >= DEALER_STAY_POINTS
          break
        elsif total(dealer_cards) < DEALER_STAY_POINTS
          prompt "Press enter to see dealer's next card."
          gets
          prompt "Dealer draw a card."
          dealer_cards << deck.pop
        end
      end
      prompt "You have a total of #{total(player_cards)},and dealer has #{total(dealer_cards)}."
      prompt "#{display_result(dealer_cards, player_cards)}"
      break
    end

    prompt "====================="
    record_score!(dealer_cards, player_cards, score)
    display_score!(score)
    prompt "Press enter to continue"
    gets
    system 'clear'
    break if score[:player] == WINNING_SCORE || score[:dealer] == WINNING_SCORE
  end
  display_winner(score)
  break unless play_again?
end
prompt "Thanks for playing.Good-bye."
