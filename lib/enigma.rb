require './lib/helpers'
class Enigma
  include Helpers
  attr_reader :character_set,
              :number_key,
              :date_key

  def initialize(key = nil, date = nil)
    @character_set = ("a".."z").to_a << " "
    @number_key = key || make_number_key
    @date_key = date || current_date
  end

  def encrypt(string, key = number_key, date = date_key)
    hash = {:encryption => "", :key => key, :date => date}
    letters = string.split(//)
    letters.each_with_index do |character, index|
      character.downcase!
      if @character_set.include?(character) != true
        hash[:encryption] += character
      elsif index % 4 == 0
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[0]) % 27))
      elsif index % 4 == 1
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[1]) % 27))
      elsif index % 4 == 2
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[2]) % 27))
      elsif index % 4 == 3
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift(key, date)[3]) % 27))
      end
    end
    hash
  end

  def decrypt(string, key, date = date_key)
    hash = {:decryption => "", :key => key, :date => date}
    letters = string.split(//)
    letters.each_with_index do |character, index|
      if @character_set.include?(character) != true
        hash[:decryption] += character
      elsif index % 4 == 0
        hash[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[0]) % 27))
      elsif index % 4 == 1
        hash[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[1]) % 27))
      elsif index % 4 == 2
        hash[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[2]) % 27))
      elsif index % 4 == 3
        hash[:decryption] += @character_set.fetch(((@character_set.index(character) - final_shift(key, date)[3]) % 27))
      end
    end
    hash
  end
end
