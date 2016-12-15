class House
  # def self.recite
  #   song = ""
  #   (1..pieces.size).each do |lines|
  #     song += combine_pieces(pieces.last(lines))
  #     if lines != pieces.size
  #       song += "\n\n"
  #     else
  #       song += "\n"
  #     end
  #   end
  # end

  def self.recite
    new.recite
  end

  def recite
    verse = (1..pieces.size)
              .map {|number| pieces.last(number)}
              .map {|pieces| combine_pieces(pieces)}
              .join("\n\n")
    verse + "\n"
  end
  # def self.combine_pieces(pieces)
  #   line = "This is "
  #   pieces.each do |piece|
  #     line += piece[0]
  #     line += "\n" if piece[1]
  #     line += (piece[1] + ' ') if piece[1]
  #   end

  #   line + '.'
  # end

  def combine_pieces(pieces)
    paragraph = pieces.map {|piece| piece.join("\n")}.join(" ")
    "This is #{paragraph}."
  end

  private 

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end

# The first sentence start with 'This is'
# "This is" + pieces[-1]
# "This is" + pieces[-2][0] \n pieces[-2][1] + pieces[-1]
# "This is" + pieces[-3][0] \n pieces[-3][1] + pieces[-2][0] \n pieces[-2][1] + pieces[-1]
# "This is" + pieces[-4][0] \n pieces[-4][1] + pieces[-3][0] \n pieces[-3][1] + pieces[-2][0] \n pieces[-2][1] + pieces[-1]
# house = House.new
# house.pieces
