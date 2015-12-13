require_relative 'encrypt'

class Decrypt < Encrypt

  def initialize(key, date)
    @key = key
    @date = date
  end

  def rotate_encrypted_message(message)
    indices_and_rotators = which_rotator(message)
    new_indices = []
    i = 0
    indices_and_rotators.length.times do
      i += 1
      new_indices << (indices_and_rotators[i-1][0] - (indices_and_rotators[i-1][1] % 39))
     end
     new_indices.map do |index|
       if index < 0
         index + 39
       else
         index
       end
     end
  end

  def decrypt(message, key = @key, date = @date)
    message = message.downcase
    new_indices = rotate_encrypted_message(message)
    decrypted_message = []
    new_indices.each do |index|
      @characters_and_indices.each do |character, location|
        if index == location
          decrypted_message << character
        end
      end
    end
    decrypted_message.join
  end
end
