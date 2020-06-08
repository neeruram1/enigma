require_relative 'coder'

class Decryption < Coder

  def decode
    rotate_message_decode
  end
end
