# require_relative 'encrypt'
# require_relative 'decrypt'
# require_relative 'crack'
# require_relative 'keys'
require_relative 'key_generator'
require_relative 'rotator'

class Enigma
  def self.encrypt(message, key, date)
    rotator(key, date).encrypt(message)
  end

  def self.decrypt(message, key, date)
    rotator(key, date).decrypt(message)
  end

  def self.crack(message, date)
    messages = 0.upto(99999).lazy.map do |x|
      self.decrypt(message, x, date)
    end
    messages.find do |m|
      m.end_with?("..end..")
    end
  end

  private

  def self.rotator(key, date)
    Rotator.new(KeyGenerator.new(key, date).key)
  end
end
