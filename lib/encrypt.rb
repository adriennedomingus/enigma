class Encrypt
  def initialize(key = @key, date = @date)
    @key = key
    @date = date
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
    indices = (0..38).to_a.flatten
    @characters_and_indices = Hash[characters.zip(indices)]
  end

  def date_offset
    @date = Time.now.strftime("%d%m%y").to_i
    offset = @date ** 2
    @date_key = offset.to_s.split("")[-4..-1].join
    @date_key
  end

  def date_rotation
    date_offset
    a_date_rotation = @date_key[0].to_i
    b_date_rotation = @date_key[1].to_i
    c_date_rotation = @date_key[2].to_i
    d_date_rotation = @date_key[3].to_i
    @date_rotations = [a_date_rotation, b_date_rotation, c_date_rotation, d_date_rotation]
    @date_rotations
  end

  def key_rotation
    a_key_rotation = @key.to_s[0..1].to_i
    b_key_rotation = @key.to_s[1..2].to_i
    c_key_rotation = @key.to_s[2..3].to_i
    d_key_rotation = @key.to_s[3..4].to_i
    @key_rotations = [a_key_rotation, b_key_rotation, c_key_rotation, d_key_rotation]
    @key_rotations
  end

  def combined_rotation(message)
    date_rotation
    key_rotation
    a_overall_rotation = @date_rotations[0] + @key_rotations[0]
    b_overall_rotation = @date_rotations[1] + @key_rotations[1]
    c_overall_rotation = @date_rotations[2] + @key_rotations[2]
    d_overall_rotation = @date_rotations[3] + @key_rotations[3]
    @overall_rotations = [a_overall_rotation, b_overall_rotation, c_overall_rotation, d_overall_rotation]
    @overall_rotations
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
      rotators << @overall_rotations[0]
      rotators << @overall_rotations[1]
      rotators << @overall_rotations[2]
      rotators << @overall_rotations[3]
    end
    until rotators.length == initial_indices.length
      rotators.pop
    end
    initial_indices.zip(rotators)
  end

  def rotate_message(message)
    indices_and_rotators = which_rotator(message)
    new_indices = []
    i = 0
    indices_and_rotators.length.times do
      i += 1
      new_indices << (indices_and_rotators[i-1][0] + (indices_and_rotators[i-1][1] % 39))
     end
     new_indices.map do |index|
       if index > 38
         index - 39
       else
         index
       end
     end
  end

  def encrypt(message, key = @key, date = @date)
    message = message.downcase
    new_indices = rotate_message(message)
    encrypted_message = []
    new_indices.each do |index|
      @characters_and_indices.each do |character, location|
        if index == location
          encrypted_message << character
        end
      end
    end
    encrypted_message.join
  end

end
