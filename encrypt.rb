require './lib/enigma'
enigma = Enigma.new
message = File.open(ARGV[0], "r")
incoming_message = message.read.chomp.strip
message.close

ARGV[2]
if ARGV[2].nil?
  enigma.encrypt(incoming_message)
elsif ARGV[2].nil? == false
  key_param = ARGV[2].rjust(5, "0")
  enigma.encrypt(incoming_message, key_param[0..4])
end

encryption = enigma.encrypt_data[:encryption]
key = enigma.encrypt_data[:key]
date = enigma.encrypt_data[:date]

writer = File.open(ARGV[1], "w")
writer.write(encryption)
writer.close

puts "\nCreated 'encrypted.txt' with the key #{key} and date #{date}"
puts "\nKeep it secret. Keep it safe.\n"
