class Scrabble
  LETTER_VALUE = {
    ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] => 1,
    ["D", "G"]                                         => 2,
    ["B", "C", "M", "P"]                               => 3,
    ["F", "H", "V", "W", "Y"]                          => 4,
    ["K"]                                              => 5,
    ["J", "X"]                                         => 8,
    ["Q", "Z"]                                         => 10
  }

  def initialize(string)
    @string = string
  end

  def self.score(string)
    Scrabble.new(string).score
  end

  def score
    return 0 unless @string =~ /[a-z]/i

    sum = 0
    @string.chars.each do |char|
      LETTER_VALUE.keys.each do |array|
        sum += LETTER_VALUE[array] if array.include? char.upcase
      end
    end

    sum
  end
end

# input: string
# output: integer
# iterate each character and sum the score of each character

  # def self.score(string)
  #   Scrabble.new(string).score
  # end
  # 因為本來的instance method score需要輸入一個argument，所以你必須要instantiate an object, 這樣才能invoke它
