class BeerSong
  def verse(num)
    if num > 0
      "#{number_of_beer(num).capitalize} of beer on the wall, #{number_of_beer(num)} of beer.\n" \
      "Take #{num == 1 ? 'it' : 'one'} down and pass it around, #{number_of_beer(num-1)} of beer on the wall.\n"
    else
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  def verses(from, to)
    from.downto(to).map { |num| verse(num) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end


  def number_of_beer(num)
    if num.zero?
      'no more bottles'
    elsif num > 1
      "#{num} bottles"
    else
      "1 bottle"
    end
  end
end