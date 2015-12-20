require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma'

class EnigmaTest < MiniTest::Test
  def test_it_encrypts_properly_with_a_small_number
    message = "hello"
    expected = "ngoAu"
    assert_equal expected, Enigma.encrypt(message, 10, Time.new(2015, 12, 10))
  end

  def test_it_encrypts_a_message
    static_date = Time.new 2015, 12, 10
    result = "L/[Th&TEF:Tr"
    assert_equal result, Enigma.encrypt("test ..end..", 97521, static_date)
  end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    result = "test ..end.."
    assert_equal result, Enigma.decrypt("L/[Th&TEF:Tr", 97521, static_date)
  end

  def test_it_cracks_and_decrypts_message
    static_date = Time.new 2015, 12, 10
    result = "test ..end.."
    assert_equal result, Enigma.crack("L/[Th&TEF:Tr", static_date)
  end
end
