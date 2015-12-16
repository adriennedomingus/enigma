require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/keys'

class KeysTest < MiniTest::Test

  def test_the_key_is_always_5_digits
    keys = []
    static_date = Time.new 2015, 12, 10
    500.times do
      e = Keys.new(message, Random.rand(0..99999), static_date)
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

  def test_it_creates_a_hash_with_all_characters_mapped_to_indices
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    assert_equal 12, e.character_chart["m"]
  end

  def test_it_returns_a_hash_of_indexed_characters
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6, "h"=>7,
              "i"=>8, "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14, "p"=>15,
              "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20, "v"=>21, "w"=>22, "x"=>23,
              "y"=>24, "z"=>25, "A"=>26, "B"=>27, "C"=>28, "D"=>29, "E"=>30, "F"=>31,
              "G"=>32, "H"=>33, "I"=>34, "J"=>35, "K"=>36, "L"=>37, "M"=>38, "N"=>39,
              "O"=>40, "P"=>41, "Q"=>42, "R"=>43, "S"=>44, "T"=>45, "U"=>46, "V"=>47,
              "W"=>48, "X"=>49, "Y"=>50, "Z"=>51, "0"=>52, "1"=>53, "2"=>54, "3"=>55,
              "4"=>56, "5"=>57, "6"=>58, "7"=>59, "8"=>60, "9"=>61, "!"=>62, "@"=>63,
              "#"=>64, "$"=>65, "%"=>66, "^"=>67, "&"=>68, "*"=>69, "("=>70, ")"=>71,
              "["=>72, "]"=>73, " "=>74, ","=>75, "."=>76, "<"=>77, ">"=>78, ";"=>79,
              ":"=>80, "/"=>81, "?"=>82, "\\"=>83, "|"=>84}
    assert_equal result, e.character_chart
    assert_equal Hash, result.class
  end

  def test_it_generates_a_four_digit_key_based_on_todays_date
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = "6225"
    assert_equal result, e.date_offset
  end

  def test_it_creates_date_rotations_based_on_date_key
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = [6, 2, 2, 5]
    assert_equal result, e.date_rotation
  end

  def test_it_creates_a_b_c_and_d_rotation_keys_based_on_key
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = [54, 43, 32, 21]
    assert_equal result, e.key_rotation
  end

  def test_it_creates_ovarall_rotations_based_on_date_and_key_rotations
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = [60, 45, 34, 26]
    assert_equal result, e.combined_rotation("message")
  end


  def test_it_maps_a_single_letter_to_its_index
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = 12
    assert_equal result, e.map_letter("m")
  end

  def test_it_maps_a_message_to_all_indices
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = [12, 4, 18, 18, 0, 6, 4]
    assert_equal result, e.map_message("message")
  end

  def test_it_knows_which_rotator_to_use
    static_date = Time.new 2015, 12, 10
    e = Keys.new(message, 54321, static_date)
    result = [[12, 60], [4, 45], [18,34], [18, 26], [0, 60], [6, 45], [4, 34]]
    assert_equal result, e.which_rotator("message")
  end

end
