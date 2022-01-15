# require './lib/helpers'
require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
incoming_text = handle.read.strip
handle.close

encrypted_text = enigma.encrypt(incoming_text)
puts "Created #{ARGV[1]} with the key #{encrypted_text[:key]} and date #{encrypted_text[:date]}"

writer = File.open(ARGV[1], "w")
writer.write(encrypted_text[:encryption])
writer.close
