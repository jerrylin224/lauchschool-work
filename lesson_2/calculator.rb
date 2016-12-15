# So now we are going to make a culculator,which gets
# the number user type and ask them how they want to
# operate
LANGUAGE = 'en'
require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key, cal)
  message = messages(key, LANGUAGE)   # make sure the "messages" method is declared above this line
  Kernel.puts("=> #{message}" + "#{cal}")
end

def valid_number?(num)
  num.to_i().nonzero?
end

def integer?(input)
  /^\d+$/.match(input)
end

def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Substracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('welcome', '') 

name = ''
  loop do
    name = gets().chomp()
  
    if name.empty?()
      prompt('valid_name')
    else
      break
    end
  end
binding.pry
prompt('show_name', 'name')


loop do # main loop
  number1 = ''
  loop do
  prompt('first_num' '')
  number1 = gets().chomp()
  if valid_number?(number1)
    break
  else
    prompt('not_valid' '')
  end

end

  number2 = ''
loop do
prompt ('second_number' '')
number2 = gets().chomp()

  if valid_number?(number2)
    break
  else
    prompt('not_valid', '')
  end
end

operator_prompt = <<-ABC
  Let me know what operation you want 
  (1 add  
  (2 substaction 
  (3 multiply 
  (4 divide 
ABC

prompt(operator_prompt)

operator = ''
loop do
  operator = gets().chomp()

  if %w(1 2 3 4).include?(operator)
    break
  else
    prompt("You must type 1 ,2 ,3 or 4")
  end
end
# Why it`s should be string?Beacuse our input is string.



prompt("#{operation_to_message(operator)} the two number")


result = case operator
    when '1'
      number1.to_i + number2.to_i
    when '2'
      number1.to_i - number2.to_i
    when '3'
      number1.to_i * number2.to_i
    when '4'
      number1.to_f / number2.to_f
    end



prompt ('your_num' '#{result}')

prompt ('do_again' '')
answer = gets().chomp()
break unless answer.downcase().start_with?('y')
# This is the situation we end the main loop.
end

prompt("Thank you for using")
