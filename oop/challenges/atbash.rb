class Atbash
  ATBASH_CONVERT = {
    'a' => 'z', 'b' => 'y', 'c' => 'x', 'd' => 'w', 'e' => 'v', 'f' => 'u',
    'g' => 't', 'h' => 's', 'i' => 'r', 'j' => 'q', 'k' => 'p', 'l' => 'o',
    'm' => 'n', 'n' => 'm', 'o' => 'l', 'p' => 'k', 'q' => 'j', 'r' => 'i',
    's' => 'h', 't' => 'g', 'u' => 'f', 'v' => 'e', 'w' => 'd', 'x' => 'c',
    'y' => 'b', 'z' => 'a'
  }


  def self.encode(string)
    string.delete('^A-Za-z0-9').downcase
          .chars.map{ |char|  char =~ /[a-z]/ ? ATBASH_CONVERT[char] : char }
          .join
          .scan(/.{1,5}/)
          .join(' ')
  end
end


puts Atbash.encode('yes')
puts Atbash.encode('no')
puts Atbash.encode('OMG')
puts Atbash.encode('O M G')
p Atbash.encode('mindblowingly')
p Atbash.encode('Testing, 1 2 3, testing.')
p Atbash.encode('Truth is fiction.')
plaintext = 'The quick brown fox jumps over the lazy dog.'
p Atbash.encode(plaintext)
