require './lib/helpable'

class Enigma
  include Helpable
  attr_reader :character_set,
              :number_key,
              :date_key

  def initialize(key = nil, date = nil)
    @character_set = ("a".."z").to_a << " "
    @number_key = key || make_number_key
    @date_key = date || current_date
  end

  def encrypt(string, key = number_key, date = date_key)
    encrypted = {:encryption => "", :key => key, :date => date}
    letters = string.split(//)
    letters.each_with_index do |character, index|
      character.downcase!
      if @character_set.include?(character) != true
        encrypted[:encryption] += character
      elsif index % 4 == 0
        encrypted[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[0]) % 27))
      elsif index % 4 == 1
        encrypted[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[1]) % 27))
      elsif index % 4 == 2
        encrypted[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[2]) % 27))
      elsif index % 4 == 3
        encrypted[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[3]) % 27))
      end
    end
    encrypted
  end

  def decrypt(string, key, date = date_key)
    decrypted = {:decryption => "", :key => key, :date => date}
    letters = string.split(//)
    letters.each_with_index do |character, index|
      if @character_set.include?(character) != true
        decrypted[:decryption] += character
      elsif index % 4 == 0
        decrypted[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[0]) % 27))
      elsif index % 4 == 1
        decrypted[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[1]) % 27))
      elsif index % 4 == 2
        decrypted[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[2]) % 27))
      elsif index % 4 == 3
        decrypted[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[3]) % 27))
      end
    end
    decrypted
  end
end
