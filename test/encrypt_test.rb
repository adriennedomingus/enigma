require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/encrypt'

class EncryptTest < MiniTest::Test

  def test_it_inherits_from_keys
    result = Keys
    assert_equal result, Encrypt.superclass
  end

  def test_it_rotates_the_message_to_new_index
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(message, 54321, static_date)
    result = [72, 49, 52, 44, 60, 51, 38]
    assert_equal result, e.rotate_message("message")
  end

  def test_it_maps_new_index_to_new_message
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(message, 54321, static_date)
    result = "[X0S8ZM"
    assert_equal result, e.encrypt("message")
  end

  def test_it_encrypts_a_message
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(message, 97521, static_date)
    result = "L/[Th&TEF:Tr"
    assert_equal result, e.encrypt("test ..end..")
  end

end
