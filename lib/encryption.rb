require_relative 'code'

class Encryption < Code

  def encode
    rotate_message_encode
  end
end
