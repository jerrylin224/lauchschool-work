class SumOfMultiples
  def self.to(limit, multiples = [3, 5])
    (0...limit).select do |num|
      multiples.any? { |multiple| num % multiple == 0 }
    end.reduce(:+)
  end

  def initialize(*multiples)
    @multiples = multiples
  end

  def to(limit)
    self.class.to(limit, @multiples)
  end
end

# 一般來說argument裡面只能放object，他這樣看起來是放了好幾個數字，而且數字會更動，所以我們用splat operator
# 把他們換成array
# 在instance method裡面invoke class method記得要變成self.class.methodname，這樣才會變成SumOfMultiples.method