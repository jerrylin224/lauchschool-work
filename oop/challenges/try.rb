require 'pry'
def sum_of_multiples(num, multiples = [3, 5])
  (1...num).select do |num|
    multiples.any? { |multiple| num % multiple == 0}
  end.reduce(:+)
end

puts sum_of_multiples(20, [5, 7])