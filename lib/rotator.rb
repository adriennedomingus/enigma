class Rotator
  CHARACTER_CHART = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7,
    "i" => 8, "j" => 9, "k" => 10, "l" => 11, "m" => 12, "n" => 13, "o" => 14, "p" => 15,
    "q" => 16, "r" => 17, "s" => 18, "t" => 19, "u" => 20, "v" => 21, "w" => 22, "x" => 23,
    "y" => 24, "z" => 25, "A" => 26, "B" => 27, "C" => 28, "D" => 29, "E" => 30, "F" => 31,
    "G" => 32, "H" => 33, "I" => 34, "J" => 35, "K" => 36, "L" => 37, "M" => 38, "N" => 39,
    "O" => 40, "P" => 41, "Q" => 42, "R" => 43, "S" => 44, "T" => 45, "U" => 46, "V" =>47,
    "W" => 48, "X" => 49, "Y" => 50, "Z" => 51, "0" => 52, "1" => 53, "2" => 54, "3" => 55,
    "4" => 56, "5" => 57, "6" => 58, "7" => 59, "8" => 60, "9" => 61, "!" => 62, "@" => 63,
    "#" => 64, "$" => 65, "%" => 66, "^" => 67, "&" => 68, "*" => 69, "(" => 70, ")" => 71,
    "[" => 72, "]" => 73, " " => 74, "," => 75, "." => 76, "<" => 77, ">" => 78, ";" => 79,
    ":" => 80, "/" => 81, "?" => 82, "\\" => 83, "|" => 84}

  def initialize(key)
    @key = key.map { |x| wrap_around(x) }
  end

  def valid_character?(character)
    CHARACTER_CHART.key?(character)
  end

  def encrypt(message)
    message.chars.map.with_index{ |c, i| rotate_by(c, @key[i % 4]) }.join
  end

  def decrypt(message)
    message.chars.map.with_index{ |c, i| rotate_by(c, -@key[i % 4]) }.join
  end

  private

  def wrap_around(number)
    number % 85
  end

  def rotate_by(character, amount)
    index_of_character = CHARACTER_CHART[character]
    rotated_index = wrap_around(index_of_character + amount)
    CHARACTER_CHART.key(rotated_index)
  end
end
