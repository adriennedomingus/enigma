require_relative 'keys'

class Decrypt < Keys

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

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  d = Decrypt.new(message, 12345, Time.now)
  decrypted = d.decrypt(message, 12345, Time.now)
  f = File.new(ARGV[1], "w")
  f.write(decrypted)
  puts "Created #{ARGV[1]} with key #{d.key} and date #{Time.now.strftime("%d%m%y").to_i}"
end
