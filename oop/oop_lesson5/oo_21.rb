class Participant
  MAX_POINTS = 21

  attr_accessor :cards, :score, :name

  def initialize
    @cards = []
    @score = 0
    @name = nil
  end

  def win?(score)
    self.score == score
  end

  def total_values
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

  def busted?
    total_values > 21
  end
end

class Player < Participant
  def set_name
    answer = nil
    loop do
      puts "What's your name?"
      answer = gets.chomp
      break unless answer.empty?

      puts "Sorry, must enter a value."
    end

    self.name = answer
  end
end

class Dealer < Participant
  DEALER_NAME = [
    "Jill Taylor", "Henley Reeves", "Jack Wilder", "Ben Campbell"
  ].freeze

  def initialize
    @name = DEALER_NAME.sample
  end
end

class Deck
  SUITS = %w(H D S C).freeze
  VALUES = %w(2 3 4 5 6 7 8 9 10 A J K Q).freeze

  attr_reader :cards

  def initialize
    reset
  end

  def reset
    @cards = SUITS.product(VALUES).shuffle
  end

  def deal
    cards.pop
  end
end

module GameMessages
  def display_welcome_message
    puts "Welcome to 21 game."
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_current_cards
    display_player_cards_in_hand
    puts "#{dealer.name} has #{dealer.cards.first} and a hidden card."
    puts ""
  end

  def display_dealer_next_card
    puts "Press enter to see dealer's card in hand."
    gets.chomp
  end

  def display_player_cards_in_hand
    puts "#{player.name} has #{player.cards} and "\
    "#{player.total_values} points in hands."
  end

  def display_dealer_cards_in_hand
    puts "#{dealer.name} has #{dealer.cards} and "\
    "#{dealer.total_values} points in hands."
  end

  def display_non_hidden_card
    display_player_cards_in_hand
    display_dealer_cards_in_hand
  end

  def display_current_score
    puts "#{player.name} got #{player.score} score."\
     " #{dealer.name} got #{dealer.score} scores."
    puts "#{@max_score - [player.score, dealer.score].max} score to go."
    puts ""
  end

  def display_dealer_name
    puts "#{player.name}, your opponet is #{dealer.name}."
    puts ""
  end

  def display_compare_result
    case compare_score
    when :player then puts "#{player.name}'s points is greater "\
      "than #{dealer.name}'s, #{player.name} won!"
    when :dealer then puts "#{dealer.name}'s points is greater "\
      "than #{player.name}'s, #{dealer.name} won!"
    when :tie    then puts "It's a tie!"
    end
  end

  def display_current_cards_and_points
    display_current_score
    display_current_cards
  end
end

module PlayerQuestions
  def ask_for_max_score
    puts "How many points should we play until?"
    answer = nil
    loop do
      answer = gets.chomp
      break if !(answer =~ /[\D|0|]/)

      puts "Sorry, must be an integer greater than 0."
    end

    @max_score = answer.to_i
  end

  def ask_for_next_round
    puts "Press enter to go next."
    gets.chomp
  end

  def ask_player_name
    player.set_name
  end

  def ask_player_to_hit_or_stay
    answer = nil
    loop do
      puts "#{player.name}, would you like to hit or stay? "\
      "(h) for hit, (s) for stay."
      answer = gets.chomp.downcase
      break if %w(h s).include? answer

      puts "Sorry, must be a valid choice."
    end
    answer
  end
end

module GameState
  def reset_participant_cards
    player.cards = []
    dealer.cards = []
  end

  def reset_participant_score
    player.score = 0
    dealer.score = 0
  end

  def update_score_by_comparing_point
    if player.busted?
      dealer.score += 1
    elsif dealer.busted?
      player.score += 1
    end
  end

  def update_score_when_someone_busted
    if compare_score == :player
      player.score += 1
    elsif compare_score == :dealer
      dealer.score += 1
    end
  end

  def update_score
    if player_and_dealer_not_busted?
      update_score_when_someone_busted
      display_compare_result
    else
      update_score_by_comparing_point
    end
  end

  def compare_score
    if player.total_values > dealer.total_values
      :player
    elsif player.total_values < dealer.total_values
      :dealer
    else
      :tie
    end
  end

  def show_busted
    if player.busted?
      puts ""
      puts "It looks like #{player.name} busted! #{dealer.name} won!"
    elsif dealer.busted?
      puts ""
      puts "It looks like #{dealer.name} busted! #{player.name} won!"
    end
  end

  def player_and_dealer_not_busted?
    !player.busted? && !dealer.busted?
  end

  def play_again?
    answer = nil
    loop do
      puts "#{player.name} ,would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts "Sorry, must be a valid choice."
    end
    answer == 'y'
  end

  def someone_reach_winning_point?
    if player.win?(@max_score)
      puts "#{player.name} reach the winning scores."\
      " #{player.name} is the final winner!"
    else
      puts "#{dealer.name} reach the winning scores."\
      " #{dealer.name} is the final winner!"
    end
  end

  def reach_winning_socre?
    player.win?(@max_score) || dealer.win?(@max_score)
  end

  def deal_two_cards_in_hand
    2.times do
      player_draw_card
      dealer_draw_card
    end
  end

  def player_draw_card
    player.cards << deck.deal
  end

  def dealer_draw_card
    dealer.cards << deck.deal
  end

  def clear_screen
    system 'clear'
  end
end

class TwentyOne
  include GameMessages
  include PlayerQuestions
  include GameState

  attr_reader :deck, :max_score, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def player_stay
    clear_screen
    display_current_score
    display_current_cards
    puts "#{player.name} chose to stay."
    puts ""
  end

  def player_hit
    clear_screen
    player_draw_card
    display_current_score
    if player.busted?
      display_non_hidden_card
    else
      display_current_cards
    end
  end

  def player_turn
    loop do
      if ask_player_to_hit_or_stay == 's'
        player_stay
        break
      elsif player.busted?
        break
      else
        player_hit
        break if player.busted?
      end
    end
  end

  def dealer_hit
    dealer_draw_card
    display_dealer_next_card
    display_dealer_cards_in_hand
  end

  def dealer_stay
    puts ""
    puts "#{dealer.name} chose to stay!"
    puts ""
  end

  def dealer_turn
    display_dealer_cards_in_hand
    loop do
      if dealer.total_values > 17 && !dealer.busted?
        dealer_stay
        break
      elsif dealer.busted?
        break
      else
        dealer_hit
      end
    end
  end

  def setting_game_information
    clear_screen
    display_welcome_message
    ask_player_name
    display_dealer_name
    ask_for_max_score
  end

  def each_participant_turn
    loop do
      deck.reset if deck.cards.size < 6
      display_current_cards_and_points
      player_turn
      if player.busted?
        show_busted
        break
      end
      dealer_turn
      if dealer.busted?
        show_busted
        break
      end
      break
    end
  end

  def before_participant_turn
    reset_participant_cards
    deal_two_cards_in_hand
    clear_screen
  end

  def after_participant_turn
    update_score
    ask_for_next_round
    clear_screen
  end

  def start
    setting_game_information
    loop do
      reset_participant_score
      loop do
        before_participant_turn
        each_participant_turn
        after_participant_turn
        break if reach_winning_socre?
      end
      display_current_score
      someone_reach_winning_point?
      break unless play_again?
    end
    display_goodbye_message
  end
end

game = TwentyOne.new
game.start
