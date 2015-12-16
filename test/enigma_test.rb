require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma'

class EnigmaTest < MiniTest::Test

  def test_it_inherits_from_encrypt
    result = Encrypt
    assert_equal result, Enigma.superclass
  end

  def test_the_key_is_always_5_digits
    keys = []
    static_date = Time.new 2015, 12, 10
    500.times do
      e = Enigma.new(Random.rand(0..99999), static_date)
      keys << e.key
    end
    key_length = []
    keys.each do |key|
      key_length << key.to_s.length
    end
    all_fives = key_length.all? do |length|
      length == 5 ? true : false
    end
    assert all_fives
  end

  def test_it_encrypts_a_message
    static_date = Time.new 2015, 12, 10
    e = Enigma.new(97521, static_date)
    result = "L/[Th&TEF:Tr"
    assert_equal result, e.encrypt("test ..end..", "97521", static_date)
  end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    e = Enigma.new(97521, static_date)
    result = "test ..end.."
    assert_equal result, e.decrypt("L/[Th&TEF:Tr", "97521", static_date)
  end

  def test_it_cracks_and_decrypts_message
    static_date = Time.new 2015, 12, 10
    e = Enigma.new(97521, static_date)
    result = "test ..end.."
    assert_equal result, e.crack("L/[Th&TEF:Tr", static_date)
  end
end
