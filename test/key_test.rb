require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/key'
require 'pry'

class KeyTest < Minitest::Test
  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_it_has_attributes
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 0], @key.numbers
    assert_equal ({}), @key.key_pairs
  end

  def test_it_can_randomize_key
    @key.stubs(:randomize_key).returns("34753")
    assert_equal "34753", @key.randomize_key
  end

  def test_it_can_split_key_into_pairs
    @key.stubs(:randomize_key).returns("34753")
    expected = [34, 47, 75, 53]

    assert_equal expected, @key.split_key
  end

  def test_it_can_group_key_pairs_by_shift
    @key.stubs(:randomize_key).returns("34753")
    expected = {
              A: 34,
              B: 47,
              C: 75,
              D: 53
            }
    assert_equal expected, @key.keys_by_shift
  end
end
