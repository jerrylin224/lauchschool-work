class Series
  def initialize(string)
    @string = string.chars.map(&:to_i)
  end

  def slices(count)
    raise ArgumentError if count > @string.size
    @string.each_cons(count).to_a
  end
end

series = Series.new('01234')
p series.slices(1)