require 'pry'
class SecretHandshake
  HAND_SHAKE = {
    "jump"            => 1000,
    "close your eyes" => 100,
    "double blink"    => 10,
    "wink"            => 1
  }

  def initialize(num)
    @num = num.to_i
  end

  def commands
    return [] if deci_to_bina(@num).zero?
    
    result = []
    binary_num = deci_to_bina(@num)
    converted_num = binary_num > 1111 ? binary_num % 10000 : binary_num

    HAND_SHAKE.each do |handshake, binary|
      result << handshake unless (converted_num / binary).zero?
      converted_num %= binary
    end

    @num >= 16 ? result : result.reverse
  end

  def deci_to_bina(num)
    binary = ""
    until num.zero?
      binary += (num % 2).to_s
      num /= 2
    end

    binary.reverse.to_i
  end
end

