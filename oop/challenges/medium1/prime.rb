class Prime
  def self.nth(n)
    fail ArgumentError if n < 1
    primes = [2]
    current_test = 3
    until primes.size == n
      primes << current_test if prime?(current_test)
      current_test += 2
    end
    primes.last
  end

  def self.prime?(number)
    (2..math.sqrt(number)).each do |test|
      return false if number % test == 0
    end
    true
  end
end