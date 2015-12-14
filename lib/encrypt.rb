require_relative 'keys'

class Encrypt < Keys

  def rotate_message(message)
    indices_and_rotators = which_rotator(message)
    new_indices = []
    i = 0
    indices_and_rotators.length.times do
      i += 1
      new_indices << ((indices_and_rotators[i - 1][0]) + ((indices_and_rotators[i - 1][1] % 85)))
     end
     new_indices.map do |index|
       index > 84 ? index - 85 : index
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


if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  e = Encrypt.new(message, Random.rand(0..99999), Time.now)
  encrypted = e.encrypt(message, Random.rand(0..99999), Time.now)
  f = File.new(ARGV[1], "w")
  f.write(encrypted)
  puts "Created #{ARGV[1]} with key# #{e.key} and date #{Time.now.strftime("%d%m%y").to_i}"
end
