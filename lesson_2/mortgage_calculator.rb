require 'pry'
NOT_VALID = "Please enter a number greater than 0."
def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i().nonzero?
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def negative?(num)
  num.to_i > 0
end

def number?(num)
  float?(num) || integer?(num) && negative?(num)
end

prompt "Weclcome to mortgage caculator.We are glad to help you."
prompt ""

amount = ''
loop do
  prompt "How much is your loan amount?(Type 12000 for 12000)"
  amount = gets().chomp()
  break if number?(amount)
  prompt NOT_VALID
end

annual_rate = ''
loop do
  prompt "What is your annual interest rate?(Type 8 for 8%)"
  annual_rate = gets().chomp()
  break if number?(annual_rate)
  prompt NOT_VALID
end

year_duration = ''
loop do
  prompt "How long is your loan duration in years?(Type 2 for 2 years)"
  year_duration = gets().chomp()
  break if number?(year_duration)
  prompt NOT_VALID
end

monthly_rate = annual_rate.to_f() / 100 / 12
month_duration = year_duration.to_f * 12

m = amount.to_f * (monthly_rate / (1 - (1 + monthly_rate)**-month_duration))

prompt("Your monthly payment should be #{m}")
