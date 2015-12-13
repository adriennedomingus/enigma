require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'

class DecryptTest < MiniTest::Test


  def test_it_rotates_the_message_to_new_index
    static_date = Time.new 2015, 12, 10
    d = Decrypt.new(message, 97521, static_date)
    result = [19, 4, 18, 19, 36, 37, 37, 4, 13, 3, 37, 37]
    assert_equal result, d.rotate_encrypted_message("fd7gw n4,cny")
  end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    e = Decrypt.new(message, 97521, static_date)
    result = "test ..end.."
    assert_equal result, e.decrypt("fd7gw n4,cny", 97521, static_date)
  end

end
