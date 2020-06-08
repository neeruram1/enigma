require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/offset'
require 'pry'

class OffsetTest < Minitest::Test
  def setup
    @offset = Offset.new("040895")
  end

  def test_it_exists
    assert_instance_of Offset, @offset
  end

  def test_it_has_attributes
    assert_equal "040895", @offset.date
  end

  def test_it_can_square_date
    assert_equal "1672401025", @offset.square_date
  end

  def test_it_can_return_last_four_digits_offset
    expected = [1, 0, 2, 5]
    assert_equal expected, @offset.split_offset
  end

  def test_it_can_group_offsets_by_shift
    expected = {
              A: 1,
              B: 0,
              C: 2,
              D: 5
            }
    assert_equal expected, @offset.offsets_by_shift
  end
end
