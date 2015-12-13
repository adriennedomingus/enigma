require_relative 'encrypt'
require_relative 'decrypt'
require_relative 'crack'
require_relative 'keys'

class Enigma < Encrypt

  def initialize(key = Random.rand(0..99999).to_s, date = Time.now.strftime("%d%m%y").to_i)
    @key = "%05d" % key
    @date = date
  end

  def encrypt(message, key = @key, date = @date)
    Encrypt.new(message, key, date).encrypt(message, key, date)
  end

  def decrypt(message, key = @key, date = @date)
    Decrypt.new(message, key, date).decrypt(message, key, date)
  end

  def crack(message, date = @date)
    Crack.new(date).crack(message, date)
  end

end
