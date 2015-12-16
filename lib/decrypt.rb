require_relative 'keys'

class Decrypt < Keys

  def rotate_encrypted_message(message)
    rotate_indices(message) { |initial, rotation| initial - rotation }   
  end

  def decrypt(message, key = @key, date = @date)
    @new_indices = rotate_encrypted_message(message)
    new_message
  end
end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  d = Decrypt.new(message, 82337, Time.now)
  decrypted = d.decrypt(message, 82337, Time.now)
  f = File.new(ARGV[1], "w")
  f.write(decrypted)
  puts "Created #{ARGV[1]} with key #{d.key} and date #{Time.now.strftime("%d%m%y").to_i}"
end
