require 'pry'
PLAY_MODE = 'choose'.freeze
INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +  # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +  # cols
                [[1, 5, 9], [3, 5, 7]]               # diagnals

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, player_score, computer_score)
  system'clear'
  puts "You are #{PLAYER_MARKER}.Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
  prompt "The score now is Player:#{player_score} Computer:#{computer_score}"
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place: #{joinor(empty_squares(brd), ', ')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry,it's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(brd, marker)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2
      return brd.select { |key, value| line.include?(key) && value == INITIAL_MARKER }.keys.first
    end
  end
  nil
end

def place_center_square(brd)
  5 if brd[5] == INITIAL_MARKER
end

def computer_places_piece!(brd)
  square =  find_at_risk_square(brd, COMPUTER_MARKER) ||
            find_at_risk_square(brd, PLAYER_MARKER) ||
            place_center_square(brd) ||
            empty_squares(brd).sample

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(arr, delimiter=', ', word='or')
  arr[-1] = "#{word} #{arr.last}" if arr.size > 1
  arr.size == 2 ? arr.join(' ') : arr.join(delimiter)
end

def who_goes_first(pick)
  turn_choice = ''
  if pick == 'choose'
    loop do
      prompt "Type 1 to go first and 2 to go second"
      turn_choice = gets.chomp
      break if ["1", "2"].include?(turn_choice)
      prompt "Please choose either 1 or 2 for the order of your turn."
    end
  end
  if turn_choice == '1'
    'Player'
  else
    'Computer'
  end
end

def place_piece!(brd, player)
  if player == 'Player'
    prompt "Your turn."
    player_places_piece!(brd)
  elsif player == 'Computer'
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  if current_player == 'Player'
    'Computer'
  else
    'Player'
  end
end

def play_again?
  ans = ''
  loop do
    prompt "You wanna play again?(y or n)"
    ans = gets.chomp
    break if %w(y yes).include?(ans)
    break if %w(n no).include?(ans)
    prompt "Sorry,I don't understand.Would you type again?"
  end
  if ans.downcase.start_with?('y')
    return true
  else
    return false
  end
end

player_score = 0
computer_score = 0

loop do
  board = initialize_board
  current_player = who_goes_first(PLAY_MODE)
  loop do
    display_board(board, player_score, computer_score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)

    break if someone_won?(board) || board_full?(board)
  end

  display_board(board, player_score, computer_score)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie."
  end

  if detect_winner(board) == 'Player'
    player_score += 1
  elsif detect_winner(board) == 'Computer'
    computer_score += 1
  else
    player_score += 0
    computer_score += 0
  end

  if player_score == 5
    prompt "You got 5 point.Good game!"
    prompt "player score is #{player_score},computer score is #{computer_score}"
    player_score = 0
    computer_score = 0
  elsif computer_score == 5
    prompt "Computer got 5 point.Good game!"
    prompt "Player score is #{player_score},Computer score is #{computer_score}"
    player_score = 0
    computer_score = 0
  end

  break unless play_again?
end
prompt "Thanks for playing tic tac toe."
