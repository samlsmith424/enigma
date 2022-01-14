class Enigma
  attr_reader :character_set,
              :number_key,
              :date_key

  def initialize(key = nil, date = nil)
    @character_set = ("a".."z").to_a << " "
    @number_key = key || make_number_key
    @date_key = date || current_date
  end

  def make_number_key
    5.times.map{rand(10)}.join
  end

  def key_shift(key)
    numbers = []
    numbers << key[0..1].to_i
    numbers << key[1..2].to_i
    numbers << key[2..3].to_i
    numbers << key[3..4].to_i
    numbers
  end

  def current_date
    # Time.now.strftime("%d/%m/%y").gsub('/', "")
    Date.today.strftime("%d%m%y")
  end

  def offset_shift(date)
    # shift = current_date.to_i ** 2
    shift = date.to_i ** 2
    shift.to_s[-4..-1].split('').map(&:to_i)
  end

  def final_shift(number_key, date_key)
    keys = key_shift(number_key)
    offsets = offset_shift(date_key)
    shifts = []
    shifts << keys[0] + offsets[0]
    shifts << keys[1] + offsets[1]
    shifts << keys[2] + offsets[2]
    shifts << keys[3] + offsets[3]
    shifts
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
