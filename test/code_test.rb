






def test_it_can_find_all_start_positions
  expected = {
            1 => "h",
            2 => "e",
            3 => "l",
            4 => "l",
            5 => "o",
            6 => " ",
            7 => "w",
            8 => "o",
            9 => "r",
            10 => "l",
            11 => "d"
          }
  assert_equal expected, @decryption.start_positions
end

def test_it_can_encode_message
  expected = "hello world"
  assert_equal expected, @decryption.decode
end

def test_it_can_encode_with_special_characters
  encryption1 = Decryption.new(@shift, "keder ohulw!")
  expected = "hello world!"
  assert_equal expected, encryption1.decode
end
