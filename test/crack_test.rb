require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/crack'

class CrackTest < MiniTest::Test

  def test_it_inherits_from_decrypt
    result = Decrypt
    assert_equal result, Crack.superclass
  end

  def test_it_shrinks_the_message_to_4_characters
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = [18, 36, 13, 7]
    assert_equal result, c.map_last_four_of_encrypted("JmPOfnZlItwOuhYAJ;ynusKnh")
  end

  def test_it_knows_a_b_c_d_overall_rotations
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = [5, 33, 22, 16]
    assert_equal result, c.overall_rotators("JmPOfnZlItwOuhYAJ;ynusKnh")
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
    result = [16, 5, 33, 22]
    assert_equal result, c.combined_rotation("JmPOfnZlItwOuhYAJ;ynusKnh")
  end

  def test_it_cracks_the_key
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = 10317
    assert_equal result, c.crack_key("JmPOfnZlItwOuhYAJ;ynusKnh")
  end

  def test_it_decrypts_message
    static_date = Time.new 2015, 12, 10
    c = Crack.new(static_date)
    result = "this is so secret ..end.."
    assert_equal result, c.crack("JmPOfnZlItwOuhYAJ;ynusKnh", static_date)
  end

end
