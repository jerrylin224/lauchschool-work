def prompt(message)
  puts ("=> #{message}")
end


def valid_number?(num)
  num.to_i().nonzero?
end

prompt("Weclcome to mortgage caculator.We are glad to help you.")
prompt("")
  loop do
  prompt("How much is your loan amount?(Plz type in number")
  amount = gets().chomp().downcase()
if amount.include? "k"
    amount * 1000 then
     break
  elsif amount.include? "w" 
    amount * 10000 then 
    break
  elsif amount.to_i != 0
    puts "Please type valid number"
  else
    break
  end
end
    


prompt("What is your monthly rate?(plz type in floatting number")
  rate = gets().chomp()
prompt("How long is your loan duration in months?")
  duration = gets().chomp()

 m = amount.to_f*(rate.to_f/(1 - (1 + rate.to_f)**-duration.to_f))

prompt("Your monthly payment should be #{m}")