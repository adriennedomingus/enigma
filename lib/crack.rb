require_relative 'decrypt'

class Crack < Decrypt
  attr_reader :overall_rotators

  def initialize(date)
    @date = date
  end

  def map_last_four_of_encrypted(message)
    @message_end = map_message(message)
    until @message_end.length == 4
      @message_end.shift
    end
    @message_end
  end

  def end_indices
    [13, 3, 76, 76]
  end

  def find_overall_rotators(message)
    map_last_four_of_encrypted(message)
    @overall_rotators = []
    4.times do |index|
      rotator = @message_end[index] - end_indices[index]
      rotator < 0 ? rotator = rotator + 85 : rotator
      @overall_rotators << rotator
    end
  end

  def order_of_rotators(message)
    @shift_rotator = (message.length - 7) % 4
  end

  def combined_rotation(message)
    find_overall_rotators(message)
    order_of_rotators(message)
    set_combined_rotations
  end

  def set_combined_rotations
    case @shift_rotator
    when 1 then @combined_rotations = @overall_rotators
    when 2 then @combined_rotations = @overall_rotators.rotate(3)
    when 3 then @combined_rotations = @overall_rotators.rotate(2)
    when 0 then @combined_rotations = @overall_rotators.rotate
    end
  end

  def crack_key(message)
    combined_rotation(message)
    date_rotation
    keys = [@combined_rotations[0] - @date_rotations[0],
           @combined_rotations[1] - @date_rotations[1],
           @combined_rotations[2] - @date_rotations[2],
           @combined_rotations[3] - @date_rotations[3]]
    new_keys = []
    keys.map do |key|
      key = "%02d" % key
      new_keys << key.to_s.chars
    end
    final_keys = new_keys.flatten
    final_keys.delete_at(1)
    final_keys.delete_at(2)
    final_keys.delete_at(4)
    actual_key = final_keys.join.to_i
    return actual_key
  end

  def crack(message, date = @date)
    decrypt(message, date)
  end

end

if __FILE__ == $PROGRAM_NAME
  message = File.read(ARGV[0]).chomp
  c = Crack.new(Time.now)
  cracked = c.crack(message, Time.now)
  f = File.new(ARGV[1], "w")
  f.write(cracked)
  puts "Created #{ARGV[1]} with key #{c.crack_key(message)} and date #{Time.now.strftime("%d%m%y").to_i}"
end
