require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/crack'

class CrackTest < MiniTest::Test

  def test_it_shrinks_the_message_to_4_characters
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = [38, 0, 9, 16]
    assert_equal result, c.map_last_four_of_encrypted(".6f3p7pi a73w1op.w8jw,ajq")
  end

  def test_it_knows_a_b_c_d_overall_rotations
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = [25, 36, 11, 18]
    assert_equal result, c.overall_rotators(".6f3p7pi a73w1op.w8jw,ajq")
  end

  def test_it_returns_a_number_by_which_to_shift_rotators
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = 3
    assert_equal result, c.order_of_rotators("m3fd7gw n4,cny")
  end

  def test_it_puts_rotators_in_correct_order
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = [18, 25, 36, 11]
    assert_equal result, c.combined_rotation(".6f3p7pi a73w1op.w8jw,ajq")
  end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = "this is so secret ..end.."
    assert_equal result, c.crack("0p,teqj.zw1tlkif0f2,lv7,f", static_date)
  end

end
