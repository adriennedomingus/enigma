class Keys
    attr_accessor :key

  def initialize(message, key, date)
    @key = "%05d" % key
    @date = date
    @message = message
  end

  def character_chart
    @characters_and_indices = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5, "g" => 6, "h" => 7,
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
  end

  def date_offset
    @date = Time.now.strftime("%d%m%y").to_i
    offset = @date ** 2
    @date_key = offset.to_s.split("")[-4..-1].join
  end

  def date_rotation
    date_offset
    @date_rotations = [@date_key[0].to_i, @date_key[1].to_i, @date_key[2].to_i, @date_key[3].to_i]
  end

  def key_rotation
    @key_rotations = [@key.to_s[0..1].to_i,
                      @key.to_s[1..2].to_i,
                      @key.to_s[2..3].to_i,
                      @key.to_s[3..4].to_i]
  end

  def combined_rotation(message)
    date_rotation
    key_rotation
    @combined_rotations = [@date_rotations[0] + @key_rotations[0],
                           @date_rotations[1] + @key_rotations[1],
                           @date_rotations[2] + @key_rotations[2],
                           @date_rotations[3] + @key_rotations[3]]
  end

  def map_letter(letter)
    character_chart
    @characters_and_indices.each do |character, index|
      if letter == character
        return index
      end
    end
  end

  def map_message(message)
    message_characters = message.chars
    message_characters.map do |character|
      map_letter(character)
    end
  end

  def which_rotator(message)
    combined_rotation(message)
    initial_indices = map_message(message)
    rotators = []
    shovels = (initial_indices.length / 4.0).ceil
    shovels.times do
      rotators << @combined_rotations[0]
      rotators << @combined_rotations[1]
      rotators << @combined_rotations[2]
      rotators << @combined_rotations[3]
    end
    until rotators.length == initial_indices.length
      rotators.pop
    end
    initial_indices.zip(rotators)
  end

end
