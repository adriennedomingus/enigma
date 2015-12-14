class Keys
    attr_accessor :key

  def initialize(message, key, date)
    @key = "%05d" % key
    @date = date
    @message = message
  end

  def character_chart
    characters = []
    characters << ("a".."z").to_a
    characters << "0"
    characters << "1"
    characters << "2"
    characters << "3"
    characters << "4"
    characters << "5"
    characters << "6"
    characters << "7"
    characters << "8"
    characters << "9"
    characters << " "
    characters << "."
    characters << ","
    characters = characters.flatten
    indices = []
    indices = (0..38).to_a
    @characters_and_indices = Hash[characters.zip(indices)]
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
