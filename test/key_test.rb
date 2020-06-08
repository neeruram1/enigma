require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/key'
require 'pry'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new("34753")
    @key1 = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_it_can_randomize_key
    Key.expects(:randomize_key).returns("23456")
    assert_equal "23456", Key.randomize_key
  end

  def test_it_has_attributes
    assert_equal "34753", @key.key
    assert_equal String, @key1.key.class
    assert_equal 5, @key1.key.length
  end

  def test_it_can_split_key_into_pairs
    expected = [34, 47, 75, 53]
    assert_equal expected, @key.split_key
  end

  def test_it_can_group_key_pairs_by_shift
    expected = {
              A: 34,
              B: 47,
              C: 75,
              D: 53
            }
    assert_equal expected, @key.keys_by_shift
  end
end
