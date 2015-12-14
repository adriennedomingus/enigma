require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'

class DecryptTest < MiniTest::Test

  def test_it_inherits_from_keys
    result = Keys
    assert_equal result, Decrypt.superclass
  end

  def test_it_rotates_the_message_to_new_index
    static_date = Time.new 2015, 12, 10
    d = Decrypt.new(message, 97521, static_date)
    result = [19, 4, 18, 19, 74, 76, 76, 4, 13, 3, 76, 76]
    assert_equal result, d.rotate_encrypted_message("L/[Th&TEF:Tr")
  end

  # def test_all_indices_are_less_than_39
  # end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    e = Decrypt.new(message, 97521, static_date)
    result = "test ..end.."
    assert_equal result, e.decrypt("L/[Th&TEF:Tr", 97521, static_date)
  end

end
