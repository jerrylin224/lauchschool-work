

  def to_roman
    result = ""
    number = self
    ROMAN_NUMERALS_DATAS.each do |key, value|
      result += key * (number / value)
      number %= value
    end
    result
  end
end