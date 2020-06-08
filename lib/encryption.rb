require_relative 'coder'

class Encryption < Coder

  def encode
    rotate_message_encode
  end
end
