require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/encrypt'

class EncryptTest < MiniTest::Test

  # def test_it_generates_a_random_key
  #   skip
    #twice generate array of 100 random numbers
  # end

  def test_it_generates_a_four_digit_key_based_on_todays_date
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = "6225"
    assert_equal result, e.date_offset
  end

  def test_it_creates_date_rotations_based_on_date_key
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [6, 2, 2, 5]
    assert_equal result, e.date_rotation
  end

  def test_it_creates_a_b_c_and_d_rotation_keys_based_on_key
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [54, 43, 32, 21]
    assert_equal result, e.key_rotation
  end

  def test_it_creates_ovarall_rotations_based_on_date_and_key_rotations
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [60, 45, 34, 26]
    assert_equal result, e.combined_rotation("message")
  end

  def test_it_returns_a_hash_of_indexed_characters
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = {"a"=>0,"b"=>1,"c"=>2,"d"=>3,"e"=>4,"f"=>5,"g"=>6, "h"=>7,"i"=>8,
              "j"=>9,"k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14, "p"=>15,"q"=>16,
              "r"=>17,"s"=>18,"t"=>19,"u"=>20,"v"=>21,"w"=>22,"x"=>23,"y"=>24,
              "z"=>25,"0"=>26,"1"=>27,"2"=>28,"3"=>29,"4"=>30,"5"=>31,"6"=>32,"7"=>33,"8"=>34,"9"=>35,
              " "=>36, "."=>37,","=>38}
    assert_equal result, e.character_chart
    assert_equal Hash, result.class
  end

  def test_it_maps_a_single_letter_to_its_index
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    60 % 39
    result = 12
    assert_equal result, e.map_letter("m")
  end

  def test_it_maps_a_word_to_all_indices
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [12, 4, 18, 18, 0, 6, 4]
    assert_equal result, e.map_message("message")
  end

  def test_it_knows_which_rotator_to_use
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [[12, 60], [4, 45], [18,34], [18, 26], [0, 60], [6, 45], [4, 34]]
    assert_equal result, e.which_rotator("message")
  end

  def test_it_rotates_the_message_to_new_index
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = [33, 10, 13, 5, 21, 12, 38]
    assert_equal result, e.rotate_message("message")
  end

  def test_it_maps_new_index_to_new_message
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(54321, static_date)
    result = "7knfvm,"
    assert_equal result, e.encrypt("message")
  end

  def test_it_encrypts_a_message
    static_date = Time.new 2015, 12, 10
    e = Encrypt.new(97521, static_date)
    result = "fd7gw n4,cny"
    assert_equal result, e.encrypt("test ..end..", 97521, static_date)
  end

end
