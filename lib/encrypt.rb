require_relative 'keys'

class Encrypt < Keys

  def verify_message(message)
    character_chart
    verified = message.chars.map do |character|
      @characters_and_indices.has_key?(character) ? true : false
    end
    verified.all? ? true : false
  end

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
    if verify_message(message) == true
      new_indices = rotate_message(message)
      encrypted_message = []
      new_indices.each do |index|
        @characters_and_indices.each do |character, location|
          if index == location
            encrypted_message << character
          end
        end
      end
      return encrypted_message.join
    else
      "Sorry, your message includes unsupported characters"
    end
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
