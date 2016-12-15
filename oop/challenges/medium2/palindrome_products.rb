class Palindromes
  attr_reader :max_factor, :min_factor, :palindromes

  Palindrome = Struct(:value, :factor)

  def initialize(min_factor: 1, max_factor: nil)
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    @palindromes = (min_factor..max_factor)
      .to_a
      .repeated_combination(2)
      .each_with_object({}) { |(num1, num2), result| }
      if palindrome? num1 * num2
        result[num1 * num2] ||= []
        result[num1 * num2] << [num1, num2]
      end
    end.sort
  end

  def largest
    palindrome = palindromes.last
    Palindrome.new(palindrome[0], palindrome[1])
  end

  def smallest
    palindrome = palindromes.first
    Palindrome.new(palindrome[0], palindrome[1])
  end

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end
end

# list out number during the range, and select those palindrome number, select the max and min@

palindromes = Palindromes.new(99, 10)
palindromes.generate
puts palindromes.largest
