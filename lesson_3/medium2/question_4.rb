sentence = "Humpty  Dumpty sat on a wall."

words = sentence.split(/\W/)
words.reverse!
new_sentence = words.join(' ') + '.'
#string.split will return to be an array


#sentence = "Humpty Dumpty sat on a wall."
#situation1
#words = sentence.split(' ')=>Split this string on a space.(Or split from)
#=>["Humpty", "Dumpty", "sat", "on", "a", "wall."]
#situation2
#words = sentence.split('')=>splits characters
#["H", "u", "m", "p", "t", "y", " ", "D", "u", "m", "p", "t", "y", " ", "s", "a", "t", " ", "o", "n", " ", "a", " ", "w", "a", "l", "l", "."]
#situation3
#words = sentence.split()
#=> ["Humpty", "Dumpty", "sat", "on", "a", "wall."]
#situation4
#words = sentence.split(/\W/)=>Split on non-word characters. split(/\W/) =>Split on one or more non-word characters.
# => ["Humpty", "Dumpty", "sat", "on", "a", "wall"]
# Contains five vegetable names.

#Step1.First use .split(/\W/) to split the string and delete the comma in the same time,so it won't affect our procedure.
#Step2.Use words.reverse! to reverse the array desructively.
#Step3.Make the array to become string and join again by words.join(' ') with a space between it.
#Step4.Don't forget to add a comma at the end of the string.