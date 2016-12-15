class Prime
  def self.nth(n)
    raise ArgumentError if n == 0
    collection = [2]
    number = 3
    until collection.size == n
      collection << number if prime?(number)
      number += 2 
    end

    collection.last
  end

  def self.prime?(number)
    (2..Math.sqrt(number)).each { |num| return false if number % num == 0 }
    true
  end
end

class Prime
  def self.nth(limit)

    raise ArgumentError if limit.zero?
    
    primes = [2]
    counter = 3

    until primes.size == limit do
      primes << counter unless primes.any? { |prime| counter % prime == 0 }
      counter += 2
    end

    primes.last
  end
end


# 要找出prime只能這樣慢慢找啊....（在不用prime class的情況下）

# def prime?(number)
#     (2..number**0.5).each { |num| return false if number % num == 0 }
#     true
#   end

p Prime.nth(6)
p Prime.nth(2)
p Prime.nth(10_001)
p Prime.nth(1)
p Prime.nth(0)