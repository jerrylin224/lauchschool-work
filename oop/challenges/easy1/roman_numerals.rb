class Fixnum
  ROMAN_NUMERALS_DATAS = { 
    'M'=> 1000,
    'CM' => 900,
    'D'=> 500,
    'CD'=> 400,
    'C' => 100,
    'XC'=> 90,
    'L'=> 50,
    'XL'=> 40,
    'X'=> 10,
    'IX'=> 9,
    'V'=> 5,
    'IV'=> 4,
    'I'=> 1
  }


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



def count(string)
    LETTER_VALUE = {
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] => 1,
    ["D", "G"]                                         => 2,
    ["B", "C", "M", "P"]                               => 3,
    ["F", "H", "V", "W", "Y"]                          => 4,
    ["K"]                                              => 5,
    ["J", "X"]                                         => 8,
    ["Q", "Z"]                                         => 10
  }.freeze
  sum = 0
  LETTER_VALUE.keys.each do |array|
    string.chars.each do |char|
      sum += LETTER_VALUE[array] if array.include? char
    end
  end

  sum
end